// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectConfig _$ProjectConfigFromJson(Map<String, dynamic> json) {
  return ProjectConfig(
    json['version'] as String,
    sets: (json['sets'] as List)
            ?.map((e) =>
                e == null ? null : VCCSSet.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
  );
}

Map<String, dynamic> _$ProjectConfigToJson(ProjectConfig instance) =>
    <String, dynamic>{
      'version': instance.version,
      'sets': instance.sets,
    };
