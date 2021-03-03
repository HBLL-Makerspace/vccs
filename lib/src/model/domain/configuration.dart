import 'package:json_annotation/json_annotation.dart';

class Configuration {
  final List<Slot> spots;

  Configuration(this.spots);
}

@JsonSerializable()
class Slot {
  final String id;
  final String name;
  final int color;
  final String cameraId;

  @JsonKey(ignore: true)
  Status status;
  @JsonKey(ignore: true)
  Camera camera;

  Slot({
    this.name,
    this.camera,
    this.cameraId,
    this.id,
    this.status = Status.NOT_CONNECTED,
    this.color,
  });
}

class Camera {
  final String model;
  final String id;
  final String name;
  final CameraProperties cameraProperties;

  Camera({this.id, this.model, this.name, this.cameraProperties});
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
