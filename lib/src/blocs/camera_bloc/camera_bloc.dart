import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vccs/src/blocs/multi_camera_bloc/camera_bloc.dart';
import 'package:vccs/src/model/backend/backend.dart';
import 'package:vccs/src/model/backend/interfaces/camera_interface.dart';
import 'package:vccs/src/model/backend/interfaces/camera_properties.dart';

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraChangePropertyState> {
  CameraBloc(this._controller) : super(CameraChangePropertyInitial());
  final ICameraController _controller;
  ICamera camera;

  @override
  Stream<CameraChangePropertyState> mapEventToState(
    CameraEvent event,
  ) async* {
    switch (event.runtimeType) {
      case ChangeCameraPropertyEvent:
        yield CameraDataState(camera,
            status: (await _controller.getCameraStatus(camera))
                .copyWith(isChangingProperty: true));
        ChangeCameraPropertyEvent typed = event as ChangeCameraPropertyEvent;
        await _controller.changeCameraProperty(typed.camera, typed.properties);
        yield CameraDataState(camera,
            status: await _controller.getCameraStatus(camera));
        break;
      case LoadCameraDataEvent:
        camera = await _controller
            .getCameraByID((event as LoadCameraDataEvent).cameraId);
        yield CameraDataState(camera,
            status: await _controller.getCameraStatus(camera));
    }
  }
}
