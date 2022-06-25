import 'dart:ffi';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:vccs/src/blocs/settings_bloc/settings_bloc.dart';

import 'package:vccs/src/globals.dart';
import 'package:vccs/src/model/backend/implementations/hbll/ring_light_controller.dart';
import 'package:vccs/src/ui/route.gr.dart';
import 'package:vccs/src/ui/widgets/widgets.dart';
import 'package:vccs/src/model/backend/backend.dart';
import 'package:vccs/src/blocs/multi_camera_bloc/camera_bloc.dart';
import 'package:vccs/src/blocs/project_list/project_list_bloc.dart';
import 'package:vccs/src/blocs/configuration_bloc/configuration_bloc.dart';

SettingsBloc settingsBloc = SettingsBloc();
RingLightController camerasCapture = RingLightController(settingsBloc);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await camerasCapture.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppData(
      controller: controller,
      camerasCapture: camerasCapture,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<MultiCameraBloc>(
            create: (context) => MultiCameraBloc(controller),
          ),
          BlocProvider<ConfigurationBloc>(
              create: (context) =>
                  ConfigurationBloc(controller)..add(ConfigurationLoadEvent())),
          BlocProvider<ProjectListBloc>(
            create: (context) => ProjectListBloc(),
          ),
          BlocProvider<SettingsBloc>(
            create: (context) => settingsBloc
              ..add(UpdateSettings(
                  autofocusLighting: Colors.white,
                  captureLighting: Colors.white)),
          )
        ],
        child: MaterialApp(
          title: 'VCCS',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.dark,
            accentColor: Colors.blue,
          ),
          home: Scaffold(
            body: ExtendedNavigator(
              router: VCCSRoute(),
            ),
          ),
        ),
      ),
    );
  }
}
