import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:vccs/src/model/backend/path_provider.dart';
import 'package:vccs/src/model/domain/project.dart';
import 'package:vccs/src/model/domain/set.dart';

class ProjectManager {
  static String version = "0.0.1-pre_alpha";
  static Future<Project> createProject(String name, String location) async {
    Project project = Project(name, location, ProjectConfig(version));
    Directory projectDir = Directory(join(location, name));
    if (projectDir.existsSync())
      return null; // Do not overwrite exsisting project.
    projectDir.createSync(recursive: true);
    if (!projectDir.existsSync()) return null;
    Directory setsDir = Directory(join(location, name, "sets"));
    setsDir.createSync(recursive: true);
    if (!setsDir.existsSync()) return null;
    File projectConf = File(join(location, name, "config.vccs"));
    projectConf.createSync(recursive: true);
    if (!projectConf.existsSync()) return null;
    projectConf.writeAsString(jsonEncode(project.config.toJson()));

    return project;
  }

  static Future<Project> loadProject(String name, String location) async {
    print("loading project: $name");
    Directory setsDir = Directory(join(location, name, "sets"));
    File configFile = File(join(location, name, "config.vccs"));
    List<VCCSSet> sets = [];
    if (!configFile.existsSync()) return null;
    ProjectConfig config =
        ProjectConfig.fromJson(jsonDecode(configFile.readAsStringSync()));
    return Project(name, location, config);
  }

  static Future<bool> createSetFolder(Project project, VCCSSet set) async {
    Directory setDir = Directory(PathProvider.getSetFolderPath(project, set));
    setDir.createSync(recursive: true);
    Directory(PathProvider.getRawImagesFolderPath(project, set))
        .createSync(recursive: true);
    Directory(PathProvider.getProcessedImagesFolderPath(project, set))
        .createSync(recursive: true);
    Directory(PathProvider.getRawThumbnailImagesFolderPath(project, set))
        .createSync(recursive: true);
    Directory(PathProvider.getProcessedThumbnailImagesFolderPath(project, set))
        .createSync(recursive: true);
    return true;
  }

  static Future<bool> saveProject(Project project) async {
    File configDir = File(join(project.location, project.name, "config.vccs"));
    configDir.writeAsStringSync(jsonEncode(project.config.toJson()));
    return true;
  }
}
