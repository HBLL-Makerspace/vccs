// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_properties.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CameraProperty _$CameraPropertyFromJson(Map<String, dynamic> json) {
  return CameraProperty(
    json['name'] as String,
    json['label'] as String,
    json['value'],
    json['readOnly'] as bool,
    _$enumDecodeNullable(_$CameraPropertyTypeEnumMap, json['type']),
  );
}

Map<String, dynamic> _$CameraPropertyToJson(CameraProperty instance) =>
    <String, dynamic>{
      'name': instance.name,
      'label': instance.label,
      'readOnly': instance.readOnly,
      'value': instance.value,
      'type': _$CameraPropertyTypeEnumMap[instance.type],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$CameraPropertyTypeEnumMap = {
  CameraPropertyType.TEXT: 'TEXT',
  CameraPropertyType.RANGE: 'RANGE',
  CameraPropertyType.TOGGLE: 'TOGGLE',
  CameraPropertyType.RADIO: 'RADIO',
  CameraPropertyType.DROPDOWN: 'DROPDOWN',
  CameraPropertyType.DATE: 'DATE',
  CameraPropertyType.UNKOWN: 'UNKOWN',
};
