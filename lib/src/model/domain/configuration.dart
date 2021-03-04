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

  Camera({this.id, this.model, this.name});
}

enum Status { CONNECTED, CONNECTING, NOT_CONNECTED }
