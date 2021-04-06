import 'package:json_annotation/json_annotation.dart';
import 'package:vccs/src/model/backend/backend.dart';

import '../camera_properties.dart';

@JsonSerializable(ignoreUnannotated: true)
class libgphoto2CameraProperties implements ICameraProperties {
  libgphoto2CameraProperties(this.properties, this.propertiesBySection);
  final Map<String, CameraProperty> properties;
  final Map<String, List<CameraProperty>> propertiesBySection;

  factory libgphoto2CameraProperties.fromJson(Map<String, dynamic> json) {
    Map<String, CameraProperty> _properties = {};
    Map<String, List<CameraProperty>> _propertiesBySection = {};
    void _recursive(
        Map<String, dynamic> json,
        Map<String, CameraProperty> props,
        Map<String, List<CameraProperty>> sectionProps,
        {String section}) {
      String _section = section;
      if (json.containsKey("children")) {
        // if ((json["children"] as List).length < 1) {
        // print(json["value"].runtimeType);
        switch (json["type"]) {
          case 1:
            _section = json["label"];
            break;
          case 2:
            // print("text property");
            props[json["name"]] = CameraTextProperty(
                json["name"],
                json["label"],
                json["value"],
                (json["readOnly"] ?? 0) == 1,
                CameraPropertyType.TEXT);
            break;
          case 3:
            // print("range property");
            props[json["name"]] = CameraRangeProperty(
                json["name"],
                json["label"],
                json["value"],
                (json["readOnly"] ?? 0) == 1,
                CameraPropertyType.RANGE,
                low: json["low"] ?? 0,
                high: json["high"] ?? 0,
                increment: json["inc"] ?? 0);
            break;
          case 4:
            // print("toggle property");
            props[json["name"]] = CameraToggleProperty(
                json["name"],
                json["label"],
                json["value"],
                (json["readOnly"] ?? 0) == 1,
                CameraPropertyType.TOGGLE);
            break;
          case 5:
          case 6:
            if ((json["choices"] ?? []).length <= 3)
              props[json["name"]] = CameraRadioProperty(
                  json["name"],
                  json["label"],
                  json["value"],
                  (json["readOnly"] ?? 0) == 1,
                  CameraPropertyType.RADIO,
                  choices: json["choices"]);
            else
              props[json["name"]] = CameraDropDownProperty(
                  json["name"],
                  json["label"],
                  json["value"],
                  (json["readOnly"] ?? 0) == 1,
                  CameraPropertyType.DROPDOWN,
                  choices: json["choices"]);
            break;
          case 8:
            props[json["name"]] = CameraDateProperty(
                json["name"],
                json["label"],
                json["value"],
                (json["readOnly"] ?? 0) == 1,
                CameraPropertyType.DATE);
            break;
          default:
            props[json["name"]] = CameraProperty(json["name"], json["label"],
                json["value"], false, CameraPropertyType.UNKOWN);
            break;
        }
        if (section != null) {
          if (sectionProps[section] == null) sectionProps[section] = [];
          sectionProps[section].add(props[json["name"]]);
        }
        // } else
        for (var child in json["children"] ?? []) {
          _recursive(child, props, sectionProps, section: _section);
        }
      }
    }

    _recursive(json, _properties, _propertiesBySection);
    // print(_properties);
    return libgphoto2CameraProperties(_properties, _propertiesBySection);
  }

  @override
  List<CameraProperty> getPropertiesInSection(String section) {
    return propertiesBySection[section] ?? [];
  }

  @override
  Map<String, CameraProperty> getPropertiesMap() {
    return properties;
  }

  @override
  CameraProperty getProperty(String property) {
    return properties[property];
  }

  @override
  List<String> getSections() {
    return propertiesBySection.keys.toList();
  }
}
