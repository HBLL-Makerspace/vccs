import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:vccs/src/model/backend/path_provider.dart';

part 'project_list_event.dart';
part 'project_list_state.dart';

class ProjectListBloc extends Bloc<ProjectListEvent, ProjectListState> {
  ProjectListBloc() : super(ProjectListInitial());

  @override
  Stream<ProjectListState> mapEventToState(
    ProjectListEvent event,
  ) async* {
    switch (event.runtimeType) {
      case LoadProjectsEvent:
        yield ProjectListLoadingState();
        Directory projectsDirectory =
            Directory(PathProvider.getProjectsDirectory());
        print(projectsDirectory);
        if (!projectsDirectory.existsSync())
          projectsDirectory.createSync(recursive: true);
        if (projectsDirectory.existsSync()) {
          yield ProjectListDataState(projectsDirectory
              .listSync()
              .toList()
              .map((e) => basename(e.path))
              .toList());
        } else
          yield ProjectListFailedState();
    }
  }
}
