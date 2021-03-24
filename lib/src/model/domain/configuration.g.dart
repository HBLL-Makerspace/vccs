// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Configuration _$ConfigurationFromJson(Map<String, dynamic> json) {
  return Configuration(
    slots: (json['slots'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k, e == null ? null : Slot.fromJson(e as Map<String, dynamic>)),
    ),
  );
}

Map<String, dynamic> _$ConfigurationToJson(Configuration instance) =>
    <String, dynamic>{
      'slots': instance.slots,
    };

Slot _$SlotFromJson(Map<String, dynamic> json) {
  return Slot(
    name: json['name'] as String,
    cameraRef: json['cameraRef'] == null
        ? null
        : CameraRef.fromJson(json['cameraRef'] as Map<String, dynamic>),
    id: json['id'] as String,
    color: json['color'] as int,
    config: (json['config'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k,
          e == null
              ? null
              : CameraProperty.fromJson(e as Map<String, dynamic>)),
    ),
  );
}

Map<String, dynamic> _$SlotToJson(Slot instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'cameraRef': instance.cameraRef,
      'config': instance.config,
    };

CameraRef _$CameraRefFromJson(Map<String, dynamic> json) {
  return CameraRef(
    json['cameraId'] as String,
    json['cameraModel'] as String,
  );
}

Map<String, dynamic> _$CameraRefToJson(CameraRef instance) => <String, dynamic>{
      'cameraId': instance.cameraId,
      'cameraModel': instance.cameraModel,
    };
