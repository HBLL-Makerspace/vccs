part of 'camera_bloc.dart';

@immutable
abstract class CameraEvent {}

class LoadCamerasEvent extends CameraEvent {}

class LoadedCamerasEvent extends CameraEvent {
  final List<ICamera> cameras;

  LoadedCamerasEvent(this.cameras);
}
