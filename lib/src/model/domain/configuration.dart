import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:vccs/src/model/backend/interfaces/camera_interface.dart';

class Configuration {
  Map<String, Slot> _slots;

  Configuration({Map<String, Slot> slots}) : _slots = slots ?? {};

  void setSlot(Slot slot) {
    _slots[slot.id] = slot;
  }

  void removeSlot(Slot slot) {
    _slots.remove(slot.id);
  }

  Slot getAssignedSlot(ICamera camera) {
    for (var slot in _slots.values) {
      if (slot.cameraRef.cameraId == camera.getId()) return slot;
    }
  }

  List<CameraRef> getAssignedCameraRefs() {
    return _slots.values.map((e) => e.cameraRef).toList();
  }

  List<Slot> getSlots() {
    List<Slot> slots_unsorted = _slots.values.toList();
    slots_unsorted.sort();
    return slots_unsorted;
  }
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

  Slot copyWith({String id, String name, String color, CameraRef cameraRef}) {
    return Slot(
        id: id ?? this.id,
        name: name ?? this.name,
        color: color ?? this.color,
        cameraRef: cameraRef ?? this.cameraRef);
  }

  @override
  int compareTo(Slot other) {
    return name.compareTo(other.name);
  }
}

@JsonSerializable()
class CameraRef {
  final String cameraId;
  final String cameraModel;

  CameraRef(this.cameraId, this.cameraModel);
}

enum Status { CONNECTED, CONNECTING, NOT_CONNECTED }
