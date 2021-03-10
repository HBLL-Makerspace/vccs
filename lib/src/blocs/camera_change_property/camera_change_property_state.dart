part of 'camera_change_property_bloc.dart';

@immutable
abstract class CameraChangePropertyState {}

class CameraChangePropertyInitial extends CameraChangePropertyState {}

class ChangingCameraPropertyState extends CameraChangePropertyState {}

class ChangedCameraPropertyState extends CameraChangePropertyState {}

class FailedChangeCameraPropertyState extends CameraChangePropertyState {
  final String reason;

  FailedChangeCameraPropertyState(this.reason);
}
