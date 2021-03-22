part of 'set_bloc.dart';

@immutable
abstract class MultiCameraCaptureState {}

class SetInitial extends MultiCameraCaptureState {}

class SetCapturingState extends MultiCameraCaptureState {}

class SetCapturedState extends MultiCameraCaptureState {}
