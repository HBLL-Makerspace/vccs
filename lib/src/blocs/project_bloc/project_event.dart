part of 'project_bloc.dart';

@immutable
abstract class ProjectEvent {}

class LoadProjectEvent extends ProjectEvent {
  final String projectName;
  final String projectLocation;

  LoadProjectEvent(this.projectName, this.projectLocation);
}

class SaveProjectEvent extends ProjectEvent {}

class CloseProjectEvent extends ProjectEvent {}

class SetMaskEvent extends ProjectEvent {
  final VCCSSet set;

  SetMaskEvent(this.set);
}

class CreateSetEvent extends ProjectEvent {
  final VCCSSet set;

  CreateSetEvent(this.set);
}
