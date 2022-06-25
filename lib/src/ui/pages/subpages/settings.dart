import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vccs/src/blocs/settings_bloc/settings_bloc.dart';
import 'package:vccs/src/ui/widgets/misc/color_picker.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is SettingsData) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                ListTile(
                  title: Text(
                    "Settings",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                ListTile(
                  title: Text("Autofocus Lighting"),
                  trailing: Container(
                    width: 20,
                    height: 20,
                    color: state.autofocusLighting,
                  ),
                  onTap: () async {
                    SettingsBloc bloc = context.read<SettingsBloc>();
                    Color color;
                    bool updated = await colorPickerDialog(
                        context, state.autofocusLighting, (value) {
                      color = value;
                    });
                    if (updated) {
                      bloc.add(UpdateSettings(
                          autofocusLighting: color,
                          captureLighting: state.captureLighting));
                    }
                  },
                ),
                ListTile(
                  title: Text("Capture Lighting"),
                  trailing: Container(
                    width: 20,
                    height: 20,
                    color: state.captureLighting,
                  ),
                  onTap: () async {
                    SettingsBloc bloc = context.read<SettingsBloc>();
                    Color color;
                    bool updated = await colorPickerDialog(
                        context, state.captureLighting, (value) {
                      color = value;
                    });
                    if (updated) {
                      bloc.add(UpdateSettings(
                          autofocusLighting: state.autofocusLighting,
                          captureLighting: color));
                    }
                  },
                )
              ],
            ),
          );
        } else {
          return Center(
            child: Text("Loading settings..."),
          );
        }
      },
    );
  }
}
