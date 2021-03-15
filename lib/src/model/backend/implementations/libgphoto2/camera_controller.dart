import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:vccs/src/model/backend/implementations/camera_properties.dart';
import 'package:vccs/src/model/backend/interfaces/camera_controller_interface.dart';
import 'package:vccs/src/model/backend/interfaces/camera_interface.dart';
import './libgphoto2_camera.dart';

import '../../path_provider.dart';

class libgphoto2CameraController implements ICameraController {
  Map<String, String> _idPortMap = {};
  Map<String, ICamera> _cameras = {};

  @override
  Future<List<ICamera>> getConnectedCameras({bool forceUpdate = false}) async {
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
    return process.exitCode == 0;
  }

  @override
  Future<ICamera> getCameraByID(String id, {bool forceUpdate = false}) async {
    return _cameras[id];
  }
}
