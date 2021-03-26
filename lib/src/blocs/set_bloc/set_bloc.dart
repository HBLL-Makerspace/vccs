import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:vccs/src/model/backend/interfaces/interfaces.dart';
import 'package:vccs/src/model/backend/interfaces/multi_camera_capture.dart';
import 'package:vccs/src/model/backend/path_provider.dart';
import 'package:vccs/src/model/domain/domian.dart';
import 'package:path/path.dart' as path;

part 'set_event.dart';
part 'set_state.dart';

class MultiCameraCaptureBloc
    extends Bloc<MultiCameraCaptureBlocEvent, MultiCameraCaptureState> {
  MultiCameraCaptureBloc(this.controller, this._cameraCapture, this.config)
      : super(SetInitial());
  IMultiCameraCapture _cameraCapture;
  ICameraController controller;
  Configuration config;

  @override
  Stream<MultiCameraCaptureState> mapEventToState(
    MultiCameraCaptureBlocEvent event,
  ) async* {
    switch (event.runtimeType) {
      case CaptureSetEvent:
        yield SetCapturingState();
        var typed = event as CaptureSetEvent;
        // First delete all the pictures in the raw folder and raw_thumbnail folder
        Directory raw = Directory(
            PathProvider.getRawImagesFolderPath(typed.project, typed.set));
        raw.listSync().forEach((element) {
          element.deleteSync();
        });

        Directory raw_thumb = Directory(
            PathProvider.getRawThumbnailImagesFolderPath(
                typed.project, typed.set));
        raw_thumb.listSync().forEach((element) {
          element.deleteSync();
        });

        for (var slot in config.getSlots()) {
          ICamera cam =
              await controller.getCameraByID(slot.cameraRef?.cameraId);
          if (cam != null) {
            controller.tether(
              cam,
              rawFolderPath:
                  PathProvider.getRawImagesFolderPath(typed.project, typed.set),
              saveAsNoType: slot.id,
            );
          }
        }
        await _cameraCapture.capture();
        imageCache.clear();
        yield SetCapturedState();
        break;
    }
  }
}
