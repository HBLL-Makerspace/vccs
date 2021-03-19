import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vccs/src/model/domain/domian.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc() : super(ProjectInitial());

  Project project = Project("dummy", "empty", ProjectConfig("0"));

  @override
  Stream<ProjectState> mapEventToState(
    ProjectEvent event,
  ) async* {
    switch (event.runtimeType) {
      case LoadProjectEvent:
        yield ProjectLoadingState();
        await Future.delayed(Duration(milliseconds: 2000));
        yield ProjectDataState(project);
        break;
      case SaveProjectEvent:
        yield ProjectSavingState();
        await Future.delayed(Duration(milliseconds: 2000));
        yield ProjectDataState(project);

        break;
      case CloseProjectEvent:
        yield ProjectClosedState();
        break;
    }
    // TODO: implement mapEventToState
  }
}
