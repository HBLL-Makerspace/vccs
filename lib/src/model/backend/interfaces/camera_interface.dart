import 'package:tuple/tuple.dart';
import 'package:vccs/src/model/backend/implementations/camera_properties.dart';
import 'package:vccs/src/model/backend/interfaces/camera_properties.dart';
import 'package:vccs/src/model/backend/interfaces/interfaces.dart';

import '../backend.dart';

abstract class ICamera {
  ICameraController controller;
  ICameraProperties properties;

  int getISO();
  double getAperture();
  Tuple2<int, int> getShutterSpeed();
  bool getAutoFocus();
  String getModel();
  String getId();

  bool get isISOReadOnly;
  bool get isApertureReadOnly;
  bool get isAutoFocusReadOnly;
  bool get isExposureCompensationReadOnly;

  Future<bool> setISO(int iso);
  Future<bool> setAutoFocus(bool enabled);
  Future<bool> setAperture(double aperture);
  Future<bool> setShutterSpeed(Tuple2<int, int> shutterSpeed);

  Future<void> captureImage();
  Future<bool> focus({Duration duration = const Duration(milliseconds: 2000)});

  CameraProperty getProperty(String name);
  List<CameraProperty> getPropertiesInSection(String section);
  Map<String, List<CameraProperty>> getPropertiesMap();

  ICamera fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
