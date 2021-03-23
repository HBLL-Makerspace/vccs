import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:vccs/main.dart';
import 'package:vccs/src/model/backend/interfaces/camera_interface.dart';
import 'package:vccs/src/model/backend/interfaces/interfaces.dart';

import 'package:vccs/src/model/backend/path_provider.dart';
import 'package:vccs/src/model/domain/domian.dart';

part 'configuration_event.dart';
part 'configuration_state.dart';

class ConfigurationBloc extends Bloc<ConfigurationEvent, ConfigurationState> {
  ConfigurationBloc(this.configuration, this._controller)
      : super(ConfigurationInitial()) {
    configuration = Configuration(slots: {});
    add(ConfigurationUpdateEvent());
  }
  Configuration configuration;
  final ICameraController _controller;

  @override
  Stream<ConfigurationState> mapEventToState(
    ConfigurationEvent event,
  ) async* {
    switch (event.runtimeType) {
      case ConfigurationLoadEvent:
        String configPath = PathProvider.getConfigurationPath();
        var file = File(configPath);
        if (!file.existsSync()) {
          file.createSync(recursive: true);
        }
        String contents = file.readAsStringSync();
        if (contents.isEmpty)
          yield ConfigurationDataState(configuration);
        else {
          configuration = Configuration.fromJson(jsonDecode(contents));
          yield ConfigurationDataState(configuration);
        }
        break;
      case SaveConfigurationEvent:
        print(configuration);
        String configPath = PathProvider.getConfigurationPath();
        var file = File(configPath);
        if (!file.existsSync()) {
          file.createSync(recursive: true);
        }
        file.writeAsStringSync(jsonEncode(configuration.toJson()));
        yield ConfigurationDataState(configuration);
        break;
      case ConfigurationUpdateEvent:
        yield ConfigurationDataState(configuration);
        break;
      case ConfigurationAddSlotEvent:
        configuration.setSlot((event as ConfigurationAddSlotEvent).slot);
        yield ConfigurationDataState(configuration);
        break;
      case ConfigurationRemoveSlotEvent:
        configuration.removeSlot((event as ConfigurationRemoveSlotEvent).slot);
        yield ConfigurationDataState(configuration);
        break;
      case ConfigurationAssignCameraToSlotEvent:
        var typed = (event as ConfigurationAssignCameraToSlotEvent);
        Slot updated = typed.slot.copyWith(
            cameraRef:
                CameraRef(typed.camera.getId(), typed.camera.getModel()));
        configuration.setSlot(updated);
        yield ConfigurationDataState(configuration);
        break;
      case ConfigurationUpdateSlotEvent:
        configuration.setSlot((event as ConfigurationUpdateSlotEvent).slot);
        yield ConfigurationDataState(configuration);

        break;
      case ConfigurationStartLiveViewEvent:
        var typed = (event as ConfigurationStartLiveViewEvent);
        await _controller.startLiveView(typed.camera);
        yield ConfigurationDataState(configuration);

        break;
    }
  }
}
