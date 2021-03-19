import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vccs/src/model/backend/project_manager.dart';
import 'package:vccs/src/model/domain/domian.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc() : super(ProjectInitial());

  Project _project;

  Project get project => _project;

  @override
  Stream<ProjectState> mapEventToState(
    ProjectEvent event,
  ) async* {
    switch (event.runtimeType) {
      case LoadProjectEvent:
        yield ProjectLoadingState();
        _project = await ProjectManager.loadProject(
            (event as LoadProjectEvent).projectName,
            (event as LoadProjectEvent).projectLocation);
        if (_project == null)
          yield ProjectFailedState();
        else
          yield ProjectDataState(_project);
        break;
      case SetMaskEvent:
        _project.setMask((event as SetMaskEvent).set);
        await _project.save();
        yield ProjectDataState(_project);
        break;
      case RemoveSetEvent:
        await _project.removeSet((event as RemoveSetEvent).set);
        await _project.save();
        yield ProjectDataState(_project);
        break;
      case CreateSetEvent:
        await _project.createSet((event as CreateSetEvent).set);
        await _project.save();
        yield ProjectDataState(_project);
        break;
      case SaveProjectEvent:
        yield ProjectSavingState();
        await _project.save();
        yield ProjectDataState(_project);
        break;
      case CloseProjectEvent:
        await _project.save();
        yield ProjectClosedState();
        break;
    }
  }
}
