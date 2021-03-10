part of 'camera_change_property_bloc.dart';

@immutable
abstract class CameraChangePropertyEvent {}

class ChangeCameraPropertyEvent extends CameraChangePropertyEvent {
  final ICamera camera;
  final CameraProperty property;

  ChangeCameraPropertyEvent(this.camera, this.property);
}
