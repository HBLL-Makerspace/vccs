import 'dart:convert';
import 'dart:io';

import 'package:vccs/src/model/domain/configuration.dart';

import '../backend.dart';

class libgphoto2CameraController implements ICameraController {
  @override
  Future<ICamera> getConnectedCameras() async {
    var process = await Process.run("gphoto2", ['--auto-detect']);
    print(process.stdout);
  }
}
