import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:vccs/src/model/backend/interfaces/camera_interface.dart';

part 'configuration.g.dart';

@JsonSerializable()
class Configuration {
  @JsonKey(name: "slots")
  Map<String, Slot> slots = {};

  Configuration({this.slots});

  void setSlot(Slot slot) {
    slots[slot.id] = slot;
  }

  void removeSlot(Slot slot) {
    slots.remove(slot.id);
  }

  Slot getAssignedSlot(ICamera camera) {
    for (var slot in slots.values) {
      if (slot.cameraRef.cameraId == camera.getId()) return slot;
    }
  }

  List<CameraRef> getAssignedCameraRefs() {
    return slots.values.map((e) => e.cameraRef).toList();
  }

  List<Slot> getSlots() {
    List<Slot> slots_unsorted = slots?.values?.toList();
    slots_unsorted?.sort();
    return slots_unsorted ?? [];
  }

  Map<String, dynamic> toJson() => _$ConfigurationToJson(this);
  factory Configuration.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationFromJson(json);
}

@JsonSerializable()
class Slot with Comparable<Slot> {
  final String id;
  final String name;
  final int color;
  final CameraRef cameraRef;

  @JsonKey(ignore: true)
  Status status;

  Slot({
    this.name,
    this.cameraRef,
    String id,
    this.status = Status.NOT_CONNECTED,
    this.color,
  }) : id = id ?? Uuid().v4();

  Slot copyWith({String id, String name, int color, CameraRef cameraRef}) {
    return Slot(
        id: id ?? this.id,
        name: name ?? this.name,
        color: color ?? this.color,
        cameraRef: cameraRef ?? this.cameraRef);
  }

  Slot unassign() {
    return Slot(
      id: this.id,
      name: this.name,
      color: this.color,
    );
  }

  @override
  int compareTo(Slot other) {
    return name.compareTo(other.name);
  }

  Map<String, dynamic> toJson() => _$SlotToJson(this);
  factory Slot.fromJson(Map<String, dynamic> json) => _$SlotFromJson(json);
}

@JsonSerializable()
class CameraRef {
  final String cameraId;
  final String cameraModel;

  CameraRef(this.cameraId, this.cameraModel);

  Map<String, dynamic> toJson() => _$CameraRefToJson(this);
  factory CameraRef.fromJson(Map<String, dynamic> json) =>
      _$CameraRefFromJson(json);
}

enum Status { CONNECTED, CONNECTING, NOT_CONNECTED }
