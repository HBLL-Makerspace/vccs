// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'libgphoto2_camera.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

libgphoto2Camera _$libgphoto2CameraFromJson(Map<String, dynamic> json) {
  return libgphoto2Camera(
    json['model'] as String,
    json['port'] as String,
    config: json['config'] == null
        ? null
        : libgphoto2CameraProperties
            .fromJson(json['config'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$libgphoto2CameraToJson(libgphoto2Camera instance) =>
    <String, dynamic>{
      'model': instance.model,
      'port': instance.port,
      'config': instance.config,
    };
