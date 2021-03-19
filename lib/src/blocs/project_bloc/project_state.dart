part of 'project_bloc.dart';

@immutable
abstract class ProjectState {}

class ProjectInitial extends ProjectState {}

class ProjectLoadingState extends ProjectState {}

class ProjectSavingState extends ProjectState {}

class ProjectFailedState extends ProjectState {}

class ProjectDataState extends ProjectState {
  final Project project;

  ProjectDataState(this.project);
}

class ProjectClosedState extends ProjectState {}
