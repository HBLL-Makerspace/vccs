part of 'camera_bloc.dart';

@immutable
abstract class CameraState {}

class CameraInitial extends CameraState {}

class LoadingCamerasState extends CameraState {}

class CamerasState extends CameraState {
  final List<ICamera> cameras;

  CamerasState(this.cameras);
}
