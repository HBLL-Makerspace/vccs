import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:vccs/src/globals.dart';
import 'package:vccs/src/model/backend/interfaces/interfaces.dart';
import 'package:vccs/src/model/backend/interfaces/multi_camera_capture.dart';
import 'package:vccs/src/model/backend/path_provider.dart';
import 'package:vccs/src/model/domain/domian.dart';
import 'package:path/path.dart' as path;

part 'set_event.dart';
part 'set_state.dart';

class MultiCameraCaptureBloc
    extends Bloc<SetBlocEvent, MultiCameraCaptureState> {
  MultiCameraCaptureBloc(this._cameraCapture, this.config)
      : super(SetInitial());
  IMultiCameraCapture _cameraCapture;
  Configuration config;

  @override
  Stream<MultiCameraCaptureState> mapEventToState(
    SetBlocEvent event,
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

        // Then tether each camera in each slot and trigger the syncronous capture.
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
      case SequentialCaptureSetEvent:
        yield SetCapturingState();
        var typed = event as SequentialCaptureSetEvent;
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

        for (var slot in configuration.getSlots()) {
          ICamera cam =
              await controller.getCameraByID(slot.cameraRef?.cameraId);

          if (cam != null)
            await controller.capture(cam,
                rawFolderPath: raw.path, saveAsNoType: slot.id);
          imageCache.clear();
        }
        yield SetCapturedState();
        break;
      case RetakeImageEvent:
        var typed = event as RetakeImageEvent;
        Directory raw = Directory(
            PathProvider.getRawImagesFolderPath(typed.project, typed.set));
        raw
            .listSync()
            .where((element) => element.path.contains(typed.slot.id))
            .forEach((element) {
          element.deleteSync();
        });

        Directory raw_thumb = Directory(
            PathProvider.getRawThumbnailImagesFolderPath(
                typed.project, typed.set));
        raw_thumb
            .listSync()
            .where((element) => element.path.contains(typed.slot.id))
            .forEach((element) {
          element.deleteSync();
        });

        ICamera cam =
            await controller.getCameraByID(typed.slot.cameraRef?.cameraId);

        if (cam != null)
          controller.capture(cam,
              rawFolderPath: raw.path, saveAsNoType: typed.slot.id);
        imageCache.clear();
        break;
    }
  }
}
