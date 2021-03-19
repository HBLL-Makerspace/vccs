import 'package:vccs/src/model/backend/backend.dart';
import 'package:vccs/src/model/backend/interfaces/interfaces.dart';

import 'camera_properties.dart';

abstract class ICameraController {
  Stream onCameraUpdate(String cameraId);
  Future<List<ICamera>> getConnectedCameras({bool forceUpdate = false});
  Stream<List<ICamera>> get connectedCameras;
  Future<bool> changeCameraProperty(
      ICamera camera, List<CameraProperty> property);
  Future<ICamera> getCameraByID(String id, {bool forceUpdate = false});
  Future<CameraStatus> getCameraStatus(ICamera camera);
  Future<bool> startLiveView(ICamera camera);
  Future<bool> stopLiveView(ICamera camera);
  Stream<void> onHardwareChanges();
  Future<void> dispose();
}
