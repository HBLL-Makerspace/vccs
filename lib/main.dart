import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vccs/src/blocs/multi_camera_bloc/camera_bloc.dart';
import 'package:vccs/src/blocs/configuration_bloc/configuration_bloc.dart';
import 'package:vccs/src/blocs/project_list/project_list_bloc.dart';
import 'package:vccs/src/globals.dart';
import 'package:vccs/src/model/backend/implementations/hbll/multi_camera_capture.dart';
import 'package:vccs/src/ui/route.gr.dart';
import 'package:vccs/src/ui/widgets/widgets.dart';

HbllMultiCameraCapture camerasCapture = HbllMultiCameraCapture();

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
