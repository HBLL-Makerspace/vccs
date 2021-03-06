import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vccs/src/model/backend/backend.dart';
import 'package:vccs/src/model/domain/camera_config.dart';
import 'package:vccs/src/ui/route.gr.dart';

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
    return MaterialApp(
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
    );
  }
}
