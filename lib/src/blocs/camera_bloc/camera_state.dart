part of 'camera_bloc.dart';

@immutable
abstract class CameraState {}

class CameraChangePropertyInitial extends CameraState {}

class CameraDataState extends CameraState {
  final ICamera camera;
  final CameraStatus status;

  CameraDataState(this.camera, {this.status = const CameraStatus.initial()});
}
