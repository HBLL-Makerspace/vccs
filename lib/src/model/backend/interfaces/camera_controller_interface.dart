import 'package:vccs/src/model/backend/backend.dart';
import 'package:vccs/src/model/backend/interfaces/interfaces.dart';

abstract class ICameraController {
  Future<List<ICamera>> getConnectedCameras();
  Future<bool> changeCameraProperty(ICamera camera, CameraProperty property);
}
