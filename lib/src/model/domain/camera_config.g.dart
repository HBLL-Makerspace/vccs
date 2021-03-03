// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CameraConfiguration _$CameraConfigurationFromJson(Map<String, dynamic> json) {
  return CameraConfiguration(
    (json['cameras'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k, e == null ? null : Config.fromJson(e as Map<String, dynamic>)),
    ),
    json['default'] == null
        ? null
        : Config.fromJson(json['default'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CameraConfigurationToJson(
        CameraConfiguration instance) =>
    <String, dynamic>{
      'cameras': instance.cameras,
      'default': instance.default_,
    };

Config _$ConfigFromJson(Map<String, dynamic> json) {
  return Config(
    small: json['small'] as String,
    large: json['large'] as String,
  );
}

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'small': instance.small,
      'large': instance.large,
    };
