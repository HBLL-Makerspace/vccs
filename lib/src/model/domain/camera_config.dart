import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'camera_config.g.dart';

@JsonSerializable()
class CameraConfiguration {
  final Map<String, Config> cameras;
  @JsonKey(name: "default")
  final Config default_;

  static CameraConfiguration _cameraConfiguration;

  CameraConfiguration(this.cameras, this.default_);

  static Future<void> load(String filename) async {
    _cameraConfiguration = CameraConfiguration.fromJson(
        jsonDecode(await rootBundle.loadString(filename)));
  }

  static Config getConfigFor(String name) {
    return _cameraConfiguration?.cameras[name] ??
        _cameraConfiguration?.default_;
  }

  static String getSmallThumbnailFor(String name) {
    return getConfigFor(name).small ?? _cameraConfiguration.default_.small;
  }

  static String getMediumThumbnailFor(String name) {
    return getConfigFor(name).medium ?? _cameraConfiguration.default_.medium;
  }

  static String getLargeThumbnailFor(String name) {
    return getConfigFor(name).large ?? _cameraConfiguration.default_.large;
  }

  factory CameraConfiguration.fromJson(Map<String, dynamic> json) =>
      _$CameraConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$CameraConfigurationToJson(this);
}

@JsonSerializable()
class Config {
  final String small;
  final String medium;
  final String large;

  Config({this.small, this.medium, this.large});

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigToJson(this);
}
