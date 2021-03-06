import 'package:json_annotation/json_annotation.dart';
import 'package:vccs/src/model/backend/interfaces/camera_properties.dart';

import '../camera_properties.dart';

@JsonSerializable()
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
        Map<String, List<CameraProperty>> sectionProps) {
      if (json.containsKey("children")) {
        if ((json["children"] as List).length < 1) {
          // print(json["value"].runtimeType);
          switch (json["type"]) {
            case 1:
              break;
            case 2:
              print("text property");
              props[json["name"]] = CameraTextProperty(json["name"],
                  json["label"], json["value"], (json["readOnly"] ?? 0) == 1);
              break;
            case 3:
              print("range property");
              props[json["name"]] = CameraRangeProperty(
                  json["name"], json["label"], (json["readOnly"] ?? 0) == 1,
                  low: json["value"][0],
                  high: json["value"][1],
                  increment: json["value"][2]);
              break;
            default:
              props[json["name"]] = CameraProperty(
                  json["name"], json["label"], json["value"], false);
              break;
          }
        } else
          for (var child in json["children"]) {
            _recursive(child, props, sectionProps);
          }
      }
    }

    _recursive(json, _properties, _propertiesBySection);
    // print(_properties);
    return libgphoto2CameraProperties(_properties, _propertiesBySection);
  }

  @override
  List<CameraProperty> getPropertiesInSection(String section) {
    // TODO: implement getPropertiesInSection
    throw UnimplementedError();
  }

  @override
  Map<String, List<CameraProperty>> getPropertiesMap() {
    // TODO: implement getPropertiesMap
    throw UnimplementedError();
  }

  @override
  CameraProperty getProperty(String property) {
    return properties[property];
  }
}
