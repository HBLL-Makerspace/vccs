part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class UpdateSettings extends SettingsEvent {
  Color autofocusLighting;
  Color captureLighting;

  UpdateSettings({this.autofocusLighting, this.captureLighting});
}
