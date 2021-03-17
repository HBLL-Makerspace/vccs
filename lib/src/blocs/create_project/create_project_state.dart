part of 'create_project_bloc.dart';

@immutable
abstract class CreateProjectState {}

class CreateProjectInitial extends CreateProjectState {}

class CreatingNewProjectState extends CreateProjectState {}

class CreatedNewProjectState extends CreateProjectState {
  final String projectName;
  final String location;

  CreatedNewProjectState(this.projectName, this.location);
}

class ProjectFailedState extends CreateProjectState {}
