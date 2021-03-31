part of 'set_bloc.dart';

@immutable
abstract class SetBlocEvent {}

class CaptureSetEvent extends SetBlocEvent {
  final VCCSSet set;
  final Project project;

  CaptureSetEvent(this.set, this.project);
}

class RetakeImageEvent extends SetBlocEvent {
  final Project project;
  final Slot slot;
  final VCCSSet set;

  RetakeImageEvent({this.slot, this.set, this.project});
}
