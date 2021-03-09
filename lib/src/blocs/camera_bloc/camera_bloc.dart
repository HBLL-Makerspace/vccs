import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vccs/src/model/backend/backend.dart';
import 'package:vccs/src/model/backend/interfaces/camera_interface.dart';
import 'package:vccs/src/model/backend/interfaces/interfaces.dart';

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(CameraInitial());
  ICameraController _controller = libgphoto2CameraController();

  @override
  Stream<CameraState> mapEventToState(
    CameraEvent event,
  ) async* {
    switch (event.runtimeType) {
      case LoadCamerasEvent:
        yield LoadingCamerasState();
        yield CamerasState(await _controller.getConnectedCameras());
        break;
      default:
        break;
    }
  }
}
