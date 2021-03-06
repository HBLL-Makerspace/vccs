import 'package:vccs/src/model/backend/backend.dart';
import 'package:vccs/src/model/backend/interfaces/interfaces.dart';

import 'camera_properties.dart';

abstract class ICameraController {
  Future<List<ICamera>> getConnectedCameras({bool forceUpdate = false});
  Future<bool> changeCameraProperty(
      ICamera camera, List<CameraProperty> property);
  Future<ICamera> getCameraByID(String id, {bool forceUpdate = false});
  Future<CameraStatus> getCameraStatus(ICamera camera);
  Future<bool> startLiveView(ICamera camera);
  Future<bool> stopLiveView(ICamera camera);
}
