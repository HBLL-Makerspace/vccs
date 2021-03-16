import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vccs/src/model/backend/interfaces/camera_interface.dart';
import 'package:vccs/src/model/backend/path_provider.dart';
import 'package:vccs/src/model/domain/domian.dart';

part 'configuration_event.dart';
part 'configuration_state.dart';

class ConfigurationBloc extends Bloc<ConfigurationEvent, ConfigurationState> {
  ConfigurationBloc(this._configuration) : super(ConfigurationInitial()) {
    add(ConfigurationUpdateEvent());
  }
  Configuration _configuration = Configuration(slots: {});

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
          yield ConfigurationDataState(_configuration);
        else {
          _configuration = Configuration.fromJson(jsonDecode(contents));
          yield ConfigurationDataState(_configuration);
        }
        break;
      case SaveConfigurationEvent:
        print(_configuration);
        String configPath = PathProvider.getConfigurationPath();
        var file = File(configPath);
        if (!file.existsSync()) {
          file.createSync(recursive: true);
        }
        file.writeAsStringSync(jsonEncode(_configuration.toJson()));
        yield ConfigurationDataState(_configuration);
        break;
      case ConfigurationUpdateEvent:
        yield ConfigurationDataState(_configuration);
        break;
      case ConfigurationAddSlotEvent:
        _configuration.setSlot((event as ConfigurationAddSlotEvent).slot);
        yield ConfigurationDataState(_configuration);
        break;
      case ConfigurationRemoveSlotEvent:
        _configuration.removeSlot((event as ConfigurationRemoveSlotEvent).slot);
        yield ConfigurationDataState(_configuration);
        break;
      case ConfigurationAssignCameraToSlotEvent:
        var typed = (event as ConfigurationAssignCameraToSlotEvent);
        Slot updated = typed.slot.copyWith(
            cameraRef:
                CameraRef(typed.camera.getId(), typed.camera.getModel()));
        _configuration.setSlot(updated);
        yield ConfigurationDataState(_configuration);
        break;
    }
  }
}
