import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vccs/src/ui/route.gr.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VCCS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, primarySwatch: Colors.blue, primaryColor: Colors.blue, accentColor: Colors.blue),
      home: ExtendedNavigator(
        router: VCCSRoute(),
      ),
    );
  }
}
