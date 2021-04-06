import 'package:vccs/src/model/backend/backend.dart';

abstract class ICameraService {
  Future<void> reloadCameras();
  Stream<ICamera> get cameras;
  Stream<ICamera> getCameraStreamById(String cameraId);
  Future<void> changeCameraProperty(
      ICamera camera, CameraProperty cameraProperty);
}
