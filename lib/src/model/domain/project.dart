import 'package:json_annotation/json_annotation.dart';
import 'package:vccs/src/model/backend/project_manager.dart';
import 'package:vccs/src/model/domain/set.dart';

part "project.g.dart";

class Project {
  final String name;
  final String location;
  final ProjectConfig config;

  Project(this.name, this.location, this.config);

  List<VCCSSet> get sets => config.sets;

  Future<void> createSet(VCCSSet set) async {
    config.sets.add(set);
    await ProjectManager.createSetFolder(this, set);
  }

  Future<void> removeSet(VCCSSet set) async {
    config.sets.remove(set);
    await ProjectManager.removeSetFolder(this, set);
  }

  void setMask(VCCSSet set) {
    for (int i = 0; i < config.sets.length; i++)
      if (config.sets[i].uid == set.uid)
        config.sets[i] = config.sets[i].copyWith(isMask: true);
      else
        config.sets[i] = config.sets[i].copyWith(isMask: false);
  }

  Future<void> save() async {
    await ProjectManager.saveProject(this);
  }

  VCCSSet getSetById(String id) {
    List<VCCSSet> sets =
        config.sets.where((element) => element.uid == id).toList();
    if (sets.isNotEmpty) return sets.first;
  }

  // void close() {}
}

@JsonSerializable()
class ProjectConfig {
  final String version;
  @JsonKey(defaultValue: [])
  final List<VCCSSet> sets;
  ProjectConfig(this.version, {this.sets = const []});
  Map<String, dynamic> toJson() => _$ProjectConfigToJson(this);
  factory ProjectConfig.fromJson(Map<String, dynamic> json) =>
      _$ProjectConfigFromJson(json);
}
