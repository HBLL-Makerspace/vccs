// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VCCSSet _$VCCSSetFromJson(Map<String, dynamic> json) {
  return VCCSSet(
    name: json['name'] as String,
    isMask: json['isMask'] as bool,
    uid: json['uid'] as String,
  );
}

Map<String, dynamic> _$VCCSSetToJson(VCCSSet instance) => <String, dynamic>{
      'name': instance.name,
      'isMask': instance.isMask,
      'uid': instance.uid,
    };
