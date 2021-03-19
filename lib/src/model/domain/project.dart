import 'package:json_annotation/json_annotation.dart';

part "project.g.dart";

class Project {
  final String name;
  final String location;
  final ProjectConfig config;

  Project(this.name, this.location, this.config);
}

@JsonSerializable()
class ProjectConfig {
  final String version;
  ProjectConfig(this.version);
  Map<String, dynamic> toJson() => _$ProjectConfigToJson(this);
  factory ProjectConfig.fromJson(Map<String, dynamic> json) =>
      _$ProjectConfigFromJson(json);
}
