import 'package:flutter/material.dart';
import 'package:vccs/src/model/backend/interfaces/camera_controller_interface.dart';

class AppData extends InheritedWidget {
  final ICameraController controller;

  AppData({
    Key key,
    this.controller,
    Widget child,
  }) : super(key: key, child: child);

  static AppData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppData>();
  }

  @override
  bool updateShouldNotify(AppData oldWidget) {
    return oldWidget.controller != controller;
  }
}
