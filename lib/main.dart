import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vccs/src/blocs/camera_bloc/camera_bloc.dart';
import 'package:vccs/src/blocs/configuration_bloc/configuration_bloc.dart';
import 'package:vccs/src/blocs/project_list/project_list_bloc.dart';
import 'package:vccs/src/model/backend/backend.dart';
import 'package:vccs/src/model/domain/camera_config.dart';
import 'package:vccs/src/model/domain/configuration.dart';
import 'package:vccs/src/ui/route.gr.dart';
import 'package:vccs/src/ui/widgets/widgets.dart';

ICameraController _controller = libgphoto2CameraController();
Configuration _config = Configuration();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PathProvider.init();
  await CameraConfiguration.load("assets/cameras/cameras.json");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppData(
      configuration: _config,
      controller: _controller,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CameraBloc>(
            create: (context) => CameraBloc(_controller),
          ),
          BlocProvider<ConfigurationBloc>(
            create: (context) => ConfigurationBloc(_config),
          ),
          BlocProvider<ProjectListBloc>(
            create: (context) => ProjectListBloc(),
          )
        ],
        child: MaterialApp(
          title: 'VCCS',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.blue,
              primaryColor: Colors.blue,
              accentColor: Colors.blue),
          home: ExtendedNavigator(
            router: VCCSRoute(),
          ),
        ),
      ),
    );
  }
}
