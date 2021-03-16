part of 'camera_bloc.dart';

@immutable
abstract class CameraChangePropertyState {}

class CameraChangePropertyInitial extends CameraChangePropertyState {}

class CameraDataState extends CameraChangePropertyState {
  final ICamera camera;
  final CameraStatus status;

  CameraDataState(this.camera, {this.status = const CameraStatus.initial()});
}
