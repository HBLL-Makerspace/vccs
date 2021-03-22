import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vccs/src/blocs/multi_camera_bloc/camera_bloc.dart';
import 'package:vccs/src/blocs/configuration_bloc/configuration_bloc.dart';
import 'package:vccs/src/blocs/project_list/project_list_bloc.dart';
import 'package:vccs/src/model/backend/backend.dart';
import 'package:vccs/src/model/backend/implementations/hbll/multi_camera_capture.dart';
import 'package:vccs/src/model/domain/camera_config.dart';
import 'package:vccs/src/model/domain/configuration.dart';
import 'package:vccs/src/ui/route.gr.dart';
import 'package:vccs/src/ui/widgets/widgets.dart';

ICameraController _controller = libgphoto2CameraController();
Configuration _config = Configuration();

HbllMultiCameraCapture camerasCapture = HbllMultiCameraCapture();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PathProvider.init();
  await CameraConfiguration.load("assets/cameras/cameras.json");
  await camerasCapture.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppData(
      controller: _controller,
      camerasCapture: camerasCapture,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<MultiCameraBloc>(
            create: (context) => MultiCameraBloc(_controller),
          ),
          BlocProvider<ConfigurationBloc>(
              create: (context) =>
                  ConfigurationBloc(_config)..add(ConfigurationLoadEvent())),
          BlocProvider<ProjectListBloc>(
            create: (context) => ProjectListBloc(),
          )
        ],
        child: MaterialApp(
          title: 'VCCS',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.dark,
            accentColor: Colors.blue,
          ),
          home: ExtendedNavigator(
            router: VCCSRoute(),
          ),
        ),
      ),
    );
  }
}
