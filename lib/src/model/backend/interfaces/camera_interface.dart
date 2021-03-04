import 'package:tuple/tuple.dart';
import 'package:vccs/src/model/backend/implementations/camera_properties.dart';
import 'package:vccs/src/model/backend/interfaces/camera_properties.dart';
import 'package:vccs/src/model/backend/interfaces/interfaces.dart';

import '../backend.dart';

abstract class ICamera {
  ICameraController _controller;
  ICameraProperties _properties;

  int get iso;
  double get aperture;
  Tuple2<int, int> get shutterSpeed;
  bool get autoFocus;
  String get model;

  bool get isISOReadOnly;
  bool get isApertureReadOnly;
  bool get isAutoFocusReadOnly;
  bool get isExposureCompensationReadOnly;

  set iso(int iso);
  set autoFocus(bool enabled);
  set aperture(double aperture);
  set shutterSpeed(Tuple2<int, int> shutterSpeed);

  Future<void> captureImage();
  Future<bool> focus({Duration duration = const Duration(milliseconds: 2000)});

  CameraProperty getProperty(String name);
  List<CameraProperty> getPropertiesInSection(String section);
  Map<String, List<CameraProperty>> getPropertiesMap();

  ICamera fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
