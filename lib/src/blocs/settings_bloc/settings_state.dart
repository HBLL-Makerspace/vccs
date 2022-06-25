part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsData extends SettingsState {
  Color autofocusLighting;
  Color captureLighting;

  SettingsData({this.autofocusLighting, this.captureLighting});
}
