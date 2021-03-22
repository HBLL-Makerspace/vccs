part of 'set_bloc.dart';

@immutable
abstract class MultiCameraCaptureBlocEvent {}

class CaptureSetEvent extends MultiCameraCaptureBlocEvent {
  final VCCSSet set;
  final Project project;

  CaptureSetEvent(this.set, this.project);
}
