import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vccs/src/model/backend/interfaces/camera_interface.dart';
import 'package:vccs/src/model/domain/domian.dart';

part 'configuration_event.dart';
part 'configuration_state.dart';

class ConfigurationBloc extends Bloc<ConfigurationEvent, ConfigurationState> {
  ConfigurationBloc(this._configuration) : super(ConfigurationInitial()) {
    add(ConfigurationUpdateEvent());
  }
  final Configuration _configuration;

  @override
  Stream<ConfigurationState> mapEventToState(
    ConfigurationEvent event,
  ) async* {
    switch (event.runtimeType) {
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
