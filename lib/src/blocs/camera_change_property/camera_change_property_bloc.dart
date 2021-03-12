import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vccs/src/model/backend/backend.dart';
import 'package:vccs/src/model/backend/interfaces/camera_interface.dart';

part 'camera_change_property_event.dart';
part 'camera_change_property_state.dart';

class CameraChangePropertyBloc
    extends Bloc<CameraChangePropertyEvent, CameraChangePropertyState> {
  CameraChangePropertyBloc(this._controller)
      : super(CameraChangePropertyInitial());
  final ICameraController _controller;

  @override
  Stream<CameraChangePropertyState> mapEventToState(
    CameraChangePropertyEvent event,
  ) async* {
    switch (event.runtimeType) {
      case ChangeCameraPropertyEvent:
        yield ChangingCameraPropertyState();
        ChangeCameraPropertyEvent typed = event as ChangeCameraPropertyEvent;
        await _controller.changeCameraProperty(typed.camera, typed.properties);
        yield ChangedCameraPropertyState();
        break;
    }
  }
}
