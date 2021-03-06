import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:vccs/src/model/backend/interfaces/camera_controller_interface.dart';
import 'package:vccs/src/model/backend/interfaces/camera_interface.dart';
import './libgphoto2_camera.dart';

import '../../path_provider.dart';

class libgphoto2CameraController implements ICameraController {
  @override
  Future<List<ICamera>> getConnectedCameras() async {
    String path = PathProvider.getPluginPath("libgphoto2");
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
          cameras.add(libgphoto2Camera.fromJson(cam));
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
  }
}
