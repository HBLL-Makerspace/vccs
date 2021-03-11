import 'package:vccs/src/model/backend/backend.dart';
import 'package:vccs/src/model/backend/interfaces/interfaces.dart';

abstract class ICameraController {
  Future<List<ICamera>> getConnectedCameras({bool forceUpdate = false});
  Future<bool> changeCameraProperty(ICamera camera, CameraProperty property);
  Future<ICamera> getCameraByID(String id, {bool forceUpdate = false});
}
