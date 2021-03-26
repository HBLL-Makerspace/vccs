import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:vccs/src/model/backend/implementations/camera_properties.dart';
import 'package:vccs/src/model/backend/interfaces/camera_controller_interface.dart';
import 'package:vccs/src/model/backend/interfaces/camera_interface.dart';
import 'package:vccs/src/model/backend/interfaces/camera_properties.dart';
import 'package:watcher/watcher.dart';
import './libgphoto2_camera.dart';

import '../../path_provider.dart';

class libgphoto2CameraController implements ICameraController {
  Map<String, String> _idPortMap = {};
  Map<String, ICamera> _cameras = {};
  Map<String, Process> _liveViewProcess = {};
  Map<String, bool> _changingProperties = {};
  Map<String, StreamController> _cameraChanges = {};
  StreamController _hardwareChanges = StreamController.broadcast();
  StreamController<List<ICamera>> _connectedCameras =
      StreamController<List<ICamera>>.broadcast();

  libgphoto2CameraController() {
    var watcher = DirectoryWatcher("/dev/bus/usb");
    print("Watching devices folder");
    watcher.events.listen((event) async {
      if (event.type == ChangeType.ADD || event.type == ChangeType.REMOVE) {
        // print(event);
        _hardwareChanges.add(true);
        _connectedCameras.add(await getConnectedCameras(forceUpdate: true));
      }
    });
  }

  @override
  Future<List<ICamera>> getConnectedCameras({bool forceUpdate = false}) async {
    // print("Getting connected cameras");
    String path = PathProvider.getPluginPath("libgphoto2");
    if (forceUpdate || _cameras.isEmpty) {
      _cameras.clear();
      _idPortMap.clear();
      List<ICamera> cameras = [];
      var process = await Process.run(
          "${join(path, "get_all_connected_cameras")}", [],
          runInShell: true,
          workingDirectory: path,
          includeParentEnvironment: true);
      if (process.exitCode == 0) {
        try {
          var jsonObj = jsonDecode(process.stdout);
          print("There are ${(jsonObj as List).length} conneceted cameras");
          for (var cam in (jsonObj as List)) {
            libgphoto2Camera cam_ = libgphoto2Camera.fromJson(cam);
            cameras.add(cam_);
            _notifyCameraListeners(cam_);
            _cameras[cam_.getId()] = cam_;
            _idPortMap[cam_.getId()] = cam_.port;
          }
          return cameras;
        } catch (e) {
          print(e);
          print("Failed to get connected cameras");
          return [];
        }
      } else {
        print("Failed to get connected cameras");
        return [];
      }
    } else
      return _cameras.values.toList();
  }

  @override
  Future<bool> changeCameraProperty(
      ICamera camera, List<CameraProperty> properties) async {
    _changingProperties[camera.getId()] = true;
    // print("updating property ${property.name} to ${property.value.toString()}");
    String path = PathProvider.getPluginPath("libgphoto2");
    var process = await Process.run(
        "${join(path, "set_camera_property")}",
        [
          jsonEncode({
            "name": camera.getModel(),
            "port": _idPortMap[camera.getId()],
            "properties": properties
                .map((e) => {"name": e.name, "value": e.value})
                .toList()
          })
        ],
        runInShell: true,
        workingDirectory: path,
        includeParentEnvironment: true);
    print(process.exitCode);
    print(process.stdout);
    print(process.stderr);
    _changingProperties.remove(camera.getId());
    return process.exitCode == 0;
  }

  @override
  Future<ICamera> getCameraByID(String id, {bool forceUpdate = false}) async {
    return _cameras[id];
  }

  @override
  Future<CameraStatus> getCameraStatus(ICamera camera) async {
    bool isLiveViewActive = _liveViewProcess.containsKey(camera?.getId());
    bool isChangingProperties =
        _changingProperties.containsKey(camera?.getId());
    return CameraStatus(isChangingProperties, isLiveViewActive);
  }

  @override
  Future<bool> startLiveView(ICamera camera) async {
    if (_liveViewProcess.containsKey(camera.getId())) return false;
    String path = PathProvider.getPluginPath("libgphoto2");
    var process =
        await Process.start(join(path, "liveview.sh"), [], runInShell: false)
            .whenComplete(() => _liveViewProcess.remove(camera.getId()));
    _liveViewProcess[camera.getId()] = process;
    process.stdout.transform(utf8.decoder).forEach(print);
    process.stderr.transform(utf8.decoder).forEach(print);
    return true;
  }

  @override
  Future<bool> stopLiveView(ICamera camera) async {
    if (_liveViewProcess.containsKey(camera.getId())) {
      var process = _liveViewProcess[camera.getId()];
      var code = process.kill(ProcessSignal.sigint);
      _liveViewProcess.remove(camera.getId());
      return code;
    } else
      return true;
  }

  @override
  Stream onCameraUpdate(String cameraId) {
    if (!_cameraChanges.containsKey(cameraId))
      _cameraChanges[cameraId] = StreamController.broadcast();
    return _cameraChanges[cameraId].stream.asBroadcastStream();
  }

  void _notifyCameraListeners(ICamera camera) {
    if (_cameraChanges.containsKey(camera?.getId()))
      _cameraChanges[camera?.getId()].add(true);
  }

  @override
  Stream<void> onHardwareChanges() {
    return _hardwareChanges.stream;
  }

  @override
  Future<void> dispose() {
    _hardwareChanges.close();
    _connectedCameras.close();
  }

  @override
  Stream<List<ICamera>> get connectedCameras => _connectedCameras.stream;

  @override
  Future<bool> tether(ICamera camera,
      {String rawFolderPath,
      String saveAsNoType = "captured",
      bool tempFile = true}) async {
    String port = _idPortMap[camera.getId()];
    rawFolderPath =
        rawFolderPath ?? join(PathProvider.getProjectsDirectory(), "temp");
    File file = File(join(rawFolderPath, saveAsNoType) + ".TMP");
    // print(filename + ".TMP");
    file.createSync(recursive: true);
    if (port != null && port.isNotEmpty) {
      _changingProperties[camera.getId()] = true;
      // print("updating property ${property.name} to ${property.value.toString()}");
      String path = PathProvider.getPluginPath("libgphoto2");
      var process = await Process.run("${join(path, "tether_download")}",
          ["--port", port, "--file", join(rawFolderPath, saveAsNoType)],
          runInShell: true,
          workingDirectory: path,
          includeParentEnvironment: true);
      // print(process.exitCode);
      print(process.stdout);
      print(process.stderr);
      _changingProperties.remove(camera.getId());
    }

    Directory dir = Directory(rawFolderPath);
    List<FileSystemEntity> files = dir.listSync(recursive: false).toList();
    // print(files);
    files = files
        .where((event) =>
            event is File &&
            basename(event.path).contains(saveAsNoType) &&
            !basename(event.path).contains("TMP"))
        .toList();

    // print(files);

    if (files.length >= 1) {
      print("processing raw images");
      String path = PathProvider.getPluginPath("libgphoto2");
      var process = await Process.run(
          "${join(path, "process_raw.sh")}",
          [
            rawFolderPath,
            join(Directory(rawFolderPath).parent.path,
                "." + basename(rawFolderPath) + "_thumb"),
            saveAsNoType,
            files[0].path.split(".")[1] ?? ""
          ],
          runInShell: true,
          includeParentEnvironment: true);
      // print(process.exitCode);
      print(process.stdout);
      print(process.stderr);
    }

    if (file.existsSync()) file.deleteSync();

    return true;
  }
}
