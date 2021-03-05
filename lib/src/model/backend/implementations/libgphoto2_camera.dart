import 'package:vccs/src/model/backend/implementations/camera_properties.dart';
import 'package:tuple/tuple.dart';
import 'package:vccs/src/model/backend/interfaces/camera_controller_interface.dart';
import 'package:vccs/src/model/backend/interfaces/camera_interface.dart';
import 'package:vccs/src/model/backend/interfaces/camera_properties.dart';

class libgphoto2Camera implements ICamera {
  @override
  Future<void> captureImage() {
    throw UnimplementedError();
  }

  @override
  Future<bool> focus({Duration duration = const Duration(milliseconds: 2000)}) {
    throw UnimplementedError();
  }

  @override
  ICamera fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  @override
  List<CameraProperty> getPropertiesInSection(String section) {
    throw UnimplementedError();
  }

  @override
  Map<String, List<CameraProperty>> getPropertiesMap() {
    throw UnimplementedError();
  }

  @override
  CameraProperty getProperty(String name) {
    throw UnimplementedError();
  }

  @override
  bool get isApertureReadOnly => throw UnimplementedError();

  @override
  bool get isAutoFocusReadOnly => throw UnimplementedError();

  @override
  bool get isExposureCompensationReadOnly => throw UnimplementedError();

  @override
  bool get isISOReadOnly => throw UnimplementedError();

  @override
  String get model => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }

  @override
  ICameraController controller;

  @override
  ICameraProperties properties;

  @override
  setAperture(double aperture) {
    throw UnimplementedError();
  }

  @override
  setAutoFocus(bool enabled) {
    throw UnimplementedError();
  }

  @override
  setISO(int iso) {
    throw UnimplementedError();
  }

  @override
  setShutterSpeed(Tuple2<int, int> shutterSpeed) {
    throw UnimplementedError();
  }

  @override
  double getAperture() {
    return double.parse(properties.getProperty("aperture") ?? "0");
  }

  @override
  bool getAutoFocus() {
    throw UnimplementedError();
  }

  @override
  int getISO() {
    throw UnimplementedError();
  }

  @override
  String getModel() {
    throw UnimplementedError();
  }

  @override
  Tuple2<int, int> getShutterSpeed() {
    throw UnimplementedError();
  }

  @override
  String getId() {
    return properties.getProperty("serialnumber").toString();
  }
}
