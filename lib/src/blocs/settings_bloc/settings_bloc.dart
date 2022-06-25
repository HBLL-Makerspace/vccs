import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  Color autofocusLighting;
  Color captureLighting;

  SettingsBloc() : super(SettingsInitial()) {
    autofocusLighting = Colors.white;
    captureLighting = Colors.white;
  }

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    switch (event.runtimeType) {
      case UpdateSettings:
        var typed = event as UpdateSettings;
        print("updating settings");
        autofocusLighting = typed.autofocusLighting;
        captureLighting = typed.captureLighting;
        yield SettingsData(
            autofocusLighting: autofocusLighting,
            captureLighting: captureLighting);
    }
  }
}
