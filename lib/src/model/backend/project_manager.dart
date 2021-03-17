import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:vccs/src/model/domain/project.dart';

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
}
