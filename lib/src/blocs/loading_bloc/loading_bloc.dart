import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vccs/src/globals.dart';
import 'package:vccs/src/model/backend/implementations/implementations.dart';
import 'package:vccs/src/model/backend/interfaces/camera_interface.dart';
import 'package:vccs/src/model/backend/path_provider.dart';
import 'package:vccs/src/model/domain/camera_config.dart';
import 'package:vccs/src/model/domain/domian.dart';

part 'loading_event.dart';
part 'loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingBloc() : super(LoadingDataState("Loading...", 0));

  @override
  Stream<LoadingState> mapEventToState(
    LoadingEvent event,
  ) async* {
    if (cameras.isEmpty) if (event is LoadEvent) {
      double progress = 0.0;
      progress += 0.1;
      yield LoadingDataState("Initializing path provider", progress);
      await PathProvider.init();

      progress += 0.1;
      yield LoadingDataState("Loading camera configurations", progress);
      await CameraConfiguration.load("assets/cameras/cameras.json");
      configuration = Configuration();
      String configPath = PathProvider.getConfigurationPath();
      var file = File(configPath);
      if (!file.existsSync()) {
        file.createSync(recursive: true);
      }
      String contents = file.readAsStringSync();
      configuration = Configuration.fromJson(jsonDecode(contents));
      progress += 0.3;
      yield LoadingDataState("Getting connected cameras", progress);
      controller = libgphoto2CameraController();
      cameras = await controller.getConnectedCameras(forceUpdate: false);

      int configurableSlots = configuration
          .getSlots()
          .where((element) => element.config?.isNotEmpty ?? false)
          .toList()
          .length;
      print(configurableSlots);

      Stream<LoadingState> configure(ICamera camera, Slot slot) async* {
        await controller.changeCameraProperty(
            camera, slot.config.values.toList());
        progress += 0.5 / configurableSlots;
        yield LoadingDataState("Configuring camera", progress);
      }

      for (var camera in cameras) {
        Slot slot = configuration.getAssignedSlot(camera);
        if (slot != null && (slot?.config?.isNotEmpty ?? false)) {
          yield* configure(camera, slot);
        }
      }

      yield LoadingDataState("Done", 1);
      yield LoadingFinished();
    } else {}
    else
      yield LoadingIgnore();
  }
}
