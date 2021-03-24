import 'package:json_annotation/json_annotation.dart';

part 'camera_properties.g.dart';

enum CameraPropertyType { TEXT, RANGE, TOGGLE, RADIO, DROPDOWN, DATE, UNKOWN }

@JsonSerializable()
class CameraProperty {
  final String name;
  final String label;
  final bool readOnly;
  final dynamic value;
  final CameraPropertyType type;

  CameraProperty(this.name, this.label, this.value, this.readOnly, this.type);

  // factory CameraProperty(String name, String label, dynamic value,
  //     bool readOnly, CameraPropertyType type) {
  //   switch (type) {
  //     case CameraPropertyType.TEXT:
  //     case CameraPropertyType.RANGE:
  //     case CameraPropertyType.TOGGLE:
  //     case CameraPropertyType.RADIO:
  //     case CameraPropertyType.DROPDOWN:
  //     case CameraPropertyType.DATE:
  //     case CameraPropertyType.UNKOWN:
  //   }
  // }

  CameraProperty copyWith(
      {String name,
      String label,
      bool readOnly,
      dynamic value,
      CameraPropertyType type}) {
    return CameraProperty(name ?? this.name, label ?? this.label,
        value ?? this.value, readOnly ?? this.readOnly, type ?? this.type);
  }

  Map<String, dynamic> toJson() => _$CameraPropertyToJson(this);
  factory CameraProperty.fromJson(Map<String, dynamic> json) =>
      _$CameraPropertyFromJson(json);
}

class CameraTextProperty extends CameraProperty {
  CameraTextProperty(
      String name, String label, value, bool readOnly, CameraPropertyType type)
      : super(name, label, value, readOnly, type);
  String getText() => value?.toString() ?? "";
}

class CameraRangeProperty extends CameraProperty {
  final double low;
  final double high;
  final double increment;

  CameraRangeProperty(
      String name, String label, value, bool readOnly, CameraPropertyType type,
      {this.low = 0, this.high = 0, this.increment = 1})
      : super(name, label, value, readOnly, type);
}

class CameraToggleProperty extends CameraProperty {
  CameraToggleProperty(
      String name, String label, value, bool readOnly, CameraPropertyType type)
      : super(name, label, value, readOnly, type);
}

class CameraRadioProperty extends CameraProperty {
  final List<dynamic> choices;
  CameraRadioProperty(
      String name, String label, value, bool readOnly, CameraPropertyType type,
      {this.choices})
      : super(name, label, value, readOnly, type);
}

class CameraDropDownProperty extends CameraProperty {
  final List<dynamic> choices;
  CameraDropDownProperty(
      String name, String label, value, bool readOnly, CameraPropertyType type,
      {this.choices})
      : super(name, label, value, readOnly, type);
}

class CameraDateProperty extends CameraProperty {
  CameraDateProperty(
      String name, String label, value, bool readOnly, CameraPropertyType type)
      : super(name, label, value, readOnly, type);
}
