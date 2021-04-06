import 'package:flutter/material.dart';
import 'package:vccs/src/model/backend/backend.dart';

class AppData extends InheritedWidget {
  final ICameraController controller;
  final IMultiCameraCapture camerasCapture;

  AppData({
    Key key,
    this.controller,
    this.camerasCapture,
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
