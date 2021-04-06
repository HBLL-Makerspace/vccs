import 'package:vccs/src/model/backend/backend.dart';

abstract class ICameraProperties {
  List<String> getSections();
  CameraProperty getProperty(String property);
  List<CameraProperty> getPropertiesInSection(String section);
  Map<String, CameraProperty> getPropertiesMap();
}

class CameraStatus {
  final bool isChangingProperty;
  final bool isLiveViewActive;

  const CameraStatus(this.isChangingProperty, this.isLiveViewActive);
  const CameraStatus.initial()
      : isChangingProperty = false,
        isLiveViewActive = false;
  CameraStatus copyWith({bool isChangingProperty, bool isLiveViewActive}) {
    return CameraStatus(isChangingProperty ?? this.isChangingProperty,
        isLiveViewActive ?? this.isLiveViewActive);
  }

  bool get canInteract => !(isChangingProperty || isLiveViewActive);
}

// enum CameraPropertyType { TEXT, RANGE, TOGGLE, RADIO, DROPDOWN, DATE }
