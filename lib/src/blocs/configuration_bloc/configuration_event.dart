part of 'configuration_bloc.dart';

@immutable
abstract class ConfigurationEvent {}

class ConfigurationUpdateEvent extends ConfigurationEvent {}

class ConfigurationAddSlotEvent extends ConfigurationEvent {
  final Slot slot;

  ConfigurationAddSlotEvent(this.slot);
}

class ConfigurationRemoveSlotEvent extends ConfigurationEvent {
  final Slot slot;

  ConfigurationRemoveSlotEvent(this.slot);
}

class ConfigurationAssignCameraToSlotEvent extends ConfigurationEvent {
  final Slot slot;
  final ICamera camera;

  ConfigurationAssignCameraToSlotEvent(this.slot, this.camera);
}

class ConfigurationUpdateSlotEvent extends ConfigurationEvent {
  final Slot slot;

  ConfigurationUpdateSlotEvent(this.slot);
}

class SaveConfigurationEvent extends ConfigurationEvent {}

class ConfigurationLoadEvent extends ConfigurationEvent {}

class ConfigurationStartLiveViewEvent extends ConfigurationEvent {
  ICamera camera;

  ConfigurationStartLiveViewEvent(this.camera);
}

class ConfigurationStopLiveViewEvent extends ConfigurationEvent {}
