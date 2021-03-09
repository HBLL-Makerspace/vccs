import 'package:json_annotation/json_annotation.dart';
import 'package:vccs/src/model/backend/implementations/camera_properties.dart';
import 'package:tuple/tuple.dart';
import 'package:vccs/src/model/backend/implementations/libgphoto2/libgphoto2_properties.dart';
import 'package:vccs/src/model/backend/interfaces/camera_controller_interface.dart';
import 'package:vccs/src/model/backend/interfaces/camera_interface.dart';
import 'package:vccs/src/model/backend/interfaces/camera_properties.dart';

part 'libgphoto2_camera.g.dart';

@JsonSerializable()
class libgphoto2Camera implements ICamera {
  final String model;
  final String port;
  final libgphoto2CameraProperties config;

  libgphoto2Camera(
    this.model,
    this.port, {
    this.config,
  });

  @override
  Future<void> captureImage() {
    throw UnimplementedError();
  }

  @override
  Future<bool> focus({Duration duration = const Duration(milliseconds: 2000)}) {
    throw UnimplementedError();
  }

  @override
  factory libgphoto2Camera.fromJson(Map<String, dynamic> json) =>
      _$libgphoto2CameraFromJson(json);

  @override
  List<CameraProperty> getPropertiesInSection(String section) {
    return properties.getPropertiesInSection(section);
  }

  @override
  Map<String, List<CameraProperty>> getPropertiesMap() {
    throw UnimplementedError();
  }

  @override
  CameraProperty getProperty(String name) {
    return properties.getProperty(name);
  }

  @override
  bool get isApertureReadOnly => throw UnimplementedError();

  @override
  bool get isAutoFocusReadOnly => throw UnimplementedError();

  @override
  bool get isExposureCompensationReadOnly => throw UnimplementedError();

  @override
  bool get isISOReadOnly => throw UnimplementedError();

  Map<String, dynamic> toJson() => _$libgphoto2CameraToJson(this);

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
  String getModel() => model;

  @override
  Tuple2<int, int> getShutterSpeed() {
    throw UnimplementedError();
  }

  @override
  String getId() {
    return properties.getProperty("serialnumber")?.value.toString();
  }

  @override
  // TODO: implement controller
  ICameraController get controller => throw UnimplementedError();

  @override
  // TODO: implement properties
  ICameraProperties get properties => config;

  @override
  List<String> getSections() {
    return properties.getSections();
  }
}
