import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vccs/src/globals.dart';
import 'package:vccs/src/model/backend/backend.dart';
import 'package:vccs/src/model/backend/interfaces/camera_interface.dart';
import 'package:vccs/src/model/backend/interfaces/interfaces.dart';
import 'package:vccs/src/model/domain/domian.dart';

part 'camera_event.dart';
part 'camera_state.dart';

class MultiCameraBloc extends Bloc<CameraEvent, CameraState> {
  MultiCameraBloc(this._controller) : super(CameraInitial()) {
    _camerasStream = _controller.connectedCameras.listen((event) {
      print(event);
      add(LoadedCamerasEvent(event));
    });
    // _hardwareChanges = _controller.onHardwareChanges().listen((event) {
    //   add(LoadCamerasEvent());
    // });
  }
  final ICameraController _controller;
  StreamSubscription _camerasStream;

  @override
  Future<void> close() async {
    super.close();
    _camerasStream.cancel();
  }

  @override
  Stream<CameraState> mapEventToState(
    CameraEvent event,
  ) async* {
    switch (event.runtimeType) {
      case LoadCamerasEvent:
        yield LoadingCamerasState();
        List<ICamera> cameras =
            await _controller.getConnectedCameras(forceUpdate: true);
        cameras.forEach((camera) {
          Slot slot = configuration.getAssignedSlot(camera);
          if (slot != null && (slot?.config?.isNotEmpty ?? false)) {
            _controller.changeCameraProperty(
                camera, slot.config.values.toList());
          }
        });
        yield CamerasState(cameras);
        break;
      case LoadedCamerasEvent:
        yield CamerasState((event as LoadedCamerasEvent).cameras);
        break;
      default:
        break;
    }
  }
}
