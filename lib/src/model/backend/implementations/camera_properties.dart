class CameraProperty {
  final String name;
  final String label;
  final bool readOnly;
  final dynamic value;

  CameraProperty(this.name, this.label, this.value, this.readOnly);
}

class CameraTextProperty extends CameraProperty {
  CameraTextProperty(String name, String label, value, bool readOnly)
      : super(name, label, value, readOnly);
  String getText() => value?.toString() ?? "";
}

class CameraRangeProperty extends CameraProperty {
  final double low;
  final double high;
  final double increment;

  CameraRangeProperty(String name, String label, value, bool readOnly,
      {this.low = 0, this.high = 0, this.increment = 1})
      : super(name, label, value, readOnly);
}

class CameraToggleProperty extends CameraProperty {
  CameraToggleProperty(String name, String label, value, bool readOnly)
      : super(name, label, value, readOnly);
}

class CameraRadioProperty extends CameraProperty {
  final List<dynamic> choices;
  CameraRadioProperty(String name, String label, value, bool readOnly,
      {this.choices})
      : super(name, label, value, readOnly);
}

class CameraDropDownProperty extends CameraProperty {
  final List<dynamic> choices;
  CameraDropDownProperty(String name, String label, value, bool readOnly,
      {this.choices})
      : super(name, label, value, readOnly);
}

class CameraDateProperty extends CameraProperty {
  CameraDateProperty(String name, String label, value, bool readOnly)
      : super(name, label, value, readOnly);
}
