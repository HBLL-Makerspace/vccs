import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vccs/src/model/backend/project_manager.dart';
import 'package:vccs/src/model/domain/project.dart';

part 'create_project_event.dart';
part 'create_project_state.dart';

class CreateProjectBloc extends Bloc<CreateProjectEvent, CreateProjectState> {
  CreateProjectBloc() : super(CreateProjectInitial());

  @override
  Stream<CreateProjectState> mapEventToState(
    CreateProjectEvent event,
  ) async* {
    switch (event.runtimeType) {
      case CreateNewProjectEvent:
        yield CreatingNewProjectState();
        var typed = event as CreateNewProjectEvent;
        Project project = await ProjectManager.createProject(
            typed.projectName, typed.location);
        if (project == null)
          yield ProjectFailedState();
        else
          // project?.close();
          yield CreatedNewProjectState(typed.projectName, typed.location);
        break;
    }
  }
}
