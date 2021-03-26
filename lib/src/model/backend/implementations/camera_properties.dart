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

  CameraTextProperty copyWith(
      {String name,
      String label,
      bool readOnly,
      dynamic value,
      CameraPropertyType type}) {
    return CameraTextProperty(name ?? this.name, label ?? this.label,
        value ?? this.value, readOnly ?? this.readOnly, type ?? this.type);
  }
}

class CameraRangeProperty extends CameraProperty {
  final double low;
  final double high;
  final double increment;

  CameraRangeProperty(
      String name, String label, value, bool readOnly, CameraPropertyType type,
      {this.low = 0, this.high = 0, this.increment = 1})
      : super(name, label, value, readOnly, type);

  CameraRangeProperty copyWith(
      {String name,
      String label,
      bool readOnly,
      dynamic value,
      double low,
      double high,
      double increment,
      CameraPropertyType type}) {
    return CameraRangeProperty(name ?? this.name, label ?? this.label,
        value ?? this.value, readOnly ?? this.readOnly, type ?? this.type,
        low: low ?? this.low,
        high: high ?? this.high,
        increment: increment ?? this.increment);
  }
}

class CameraToggleProperty extends CameraProperty {
  CameraToggleProperty(
      String name, String label, value, bool readOnly, CameraPropertyType type)
      : super(name, label, value, readOnly, type);

  CameraToggleProperty copyWith(
      {String name,
      String label,
      bool readOnly,
      dynamic value,
      CameraPropertyType type}) {
    return CameraToggleProperty(name ?? this.name, label ?? this.label,
        value ?? this.value, readOnly ?? this.readOnly, type ?? this.type);
  }
}

class CameraRadioProperty extends CameraProperty {
  final List<dynamic> choices;
  CameraRadioProperty(
      String name, String label, value, bool readOnly, CameraPropertyType type,
      {this.choices})
      : super(name, label, value, readOnly, type);

  CameraRadioProperty copyWith(
      {String name,
      String label,
      bool readOnly,
      dynamic value,
      List<dynamic> choices,
      CameraPropertyType type}) {
    return CameraRadioProperty(
      name ?? this.name,
      label ?? this.label,
      value ?? this.value,
      readOnly ?? this.readOnly,
      type ?? this.type,
      choices: choices ?? this.choices,
    );
  }
}

class CameraDropDownProperty extends CameraProperty {
  final List<dynamic> choices;
  CameraDropDownProperty(
      String name, String label, value, bool readOnly, CameraPropertyType type,
      {this.choices})
      : super(name, label, value, readOnly, type);

  CameraDropDownProperty copyWith(
      {String name,
      String label,
      bool readOnly,
      dynamic value,
      List<dynamic> choices,
      CameraPropertyType type}) {
    return CameraDropDownProperty(
      name ?? this.name,
      label ?? this.label,
      value ?? this.value,
      readOnly ?? this.readOnly,
      type ?? this.type,
      choices: choices ?? this.choices,
    );
  }
}

class CameraDateProperty extends CameraProperty {
  CameraDateProperty(
      String name, String label, value, bool readOnly, CameraPropertyType type)
      : super(name, label, value, readOnly, type);

  CameraDateProperty copyWith(
      {String name,
      String label,
      bool readOnly,
      dynamic value,
      CameraPropertyType type}) {
    return CameraDateProperty(
      name ?? this.name,
      label ?? this.label,
      value ?? this.value,
      readOnly ?? this.readOnly,
      type ?? this.type,
    );
  }
}
