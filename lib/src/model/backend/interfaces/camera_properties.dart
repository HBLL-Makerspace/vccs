import 'package:vccs/src/model/backend/implementations/camera_properties.dart';

abstract class ICameraProperties {
  CameraProperty getProperty(String property);
  List<CameraProperty> getPropertiesInSection(String section);
  Map<String, List<CameraProperty>> getPropertiesMap();
}

// enum CameraPropertyType { TEXT, RANGE, TOGGLE, RADIO, DROPDOWN, DATE }
