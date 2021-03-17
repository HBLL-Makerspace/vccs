part of 'create_project_bloc.dart';

@immutable
abstract class CreateProjectEvent {}

class CreateNewProjectEvent extends CreateProjectEvent {
  final String projectName;
  final String location;

  CreateNewProjectEvent(this.projectName, this.location);
}
