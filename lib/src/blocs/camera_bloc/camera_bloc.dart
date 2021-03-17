import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vccs/src/model/backend/backend.dart';
import 'package:vccs/src/model/backend/interfaces/camera_interface.dart';
import 'package:vccs/src/model/backend/interfaces/camera_properties.dart';

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc(this._controller) : super(CameraChangePropertyInitial());
  final ICameraController _controller;
  ICamera camera;
  StreamSubscription _stream;

  @override
  Future<void> close() async {
    await super.close();
    if (_stream != null) _stream.cancel();
  }

  @override
  Stream<CameraState> mapEventToState(
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
        var typed = (event as LoadCameraDataEvent);
        camera = await _controller.getCameraByID(typed.cameraId);
        if (_stream != null) _stream.cancel();
        _stream = _controller.onCameraUpdate(typed.cameraId).listen((event) {
          add(LoadCameraDataEvent(typed.cameraId));
        });
        yield CameraDataState(camera,
            status: await _controller.getCameraStatus(camera));
    }
  }
}
