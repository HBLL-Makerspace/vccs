import 'package:json_annotation/json_annotation.dart';

class Configuration {
  final List<Slot> spots;

  Configuration(this.spots);
}

@JsonSerializable()
class Slot {
  final String id;
  final int color;
  final String camera_sn;

  @JsonKey(ignore: true)
  Status status;
  @JsonKey(ignore: true)
  Camera camera;

  Slot({
    this.camera,
    this.camera_sn,
    this.id,
    this.status = Status.NOT_CONNECTED,
    this.color,
  });
}

class Camera {
  final String model;
  final String make;
  final String serialNumber;
  final String name;
  final CameraProperties cameraProperties;

  Camera(
      {this.make,
      this.serialNumber,
      this.model,
      this.name,
      this.cameraProperties});
}

class CameraProperties {
  final int iso;
  final int aperture;
  final String shutter;
  final int exposureCompensation;

  CameraProperties(
      {this.iso, this.aperture, this.shutter, this.exposureCompensation});
}

enum Status { CONNECTED, CONNECTING, NOT_CONNECTED }
