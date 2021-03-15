part of 'camera_bloc.dart';

@immutable
abstract class CameraEvent {}

class ChangeCameraPropertyEvent extends CameraEvent {
  final ICamera camera;
  final List<CameraProperty> properties;

  ChangeCameraPropertyEvent(this.camera, this.properties);
}

class LoadCameraDataEvent extends CameraEvent {
  final String cameraId;

  LoadCameraDataEvent(this.cameraId);
}
