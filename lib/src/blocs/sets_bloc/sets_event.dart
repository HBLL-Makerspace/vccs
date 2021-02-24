part of 'sets_bloc.dart';

@immutable
abstract class SetsEvent {}

class CreateSetEvent extends SetsEvent {
  final Set set;

  CreateSetEvent(this.set);
}

class LoadSetsEvent extends SetsEvent {}

class DeleteSetEvent extends SetsEvent {}
