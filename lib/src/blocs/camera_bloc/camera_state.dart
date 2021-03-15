part of 'camera_bloc.dart';

@immutable
abstract class CameraChangePropertyState {}

class CameraChangePropertyInitial extends CameraChangePropertyState {}

class CameraDataState extends CameraChangePropertyState {
  final bool isChaningProperties;
  final bool isLiveViewActive;
  final bool isCameraCaptureInProgress;
  final bool isGettingPreview;
  final ICamera camera;

  CameraDataState(
    this.camera, {
    this.isChaningProperties = false,
    this.isLiveViewActive = false,
    this.isCameraCaptureInProgress = false,
    this.isGettingPreview = false,
  });
}
