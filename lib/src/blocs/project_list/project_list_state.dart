part of 'project_list_bloc.dart';

@immutable
abstract class ProjectListState {}

class ProjectListInitial extends ProjectListState {}

class ProjectListLoadingState extends ProjectListState {}

class ProjectListDataState extends ProjectListState {
  final List<String> projects;

  ProjectListDataState(this.projects);
}

class ProjectListFailedState extends ProjectListState {}
