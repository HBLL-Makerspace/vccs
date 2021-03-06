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

  CameraRangeProperty(String name, String label, bool readOnly,
      {this.low = 0, this.high = 0, this.increment = 1})
      : super(name, label, [low, high, increment], readOnly);
}

// class CameraToggleProperty extends CameraProperty {
// }

// class CameraRadioProperty extends CameraProperty {
// }

// class CameraDropDownProperty extends CameraProperty {
// }

// class CameraDateProperty extends CameraProperty {
// }
