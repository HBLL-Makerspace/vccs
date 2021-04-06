import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:vccs/src/model/domain/domian.dart';

class PathProvider {
  static Directory applicationDocumentsDirectory;
  static Directory tempDirectory;

  static Future<void> init() async {
    applicationDocumentsDirectory = await getApplicationDocumentsDirectory();
    tempDirectory = await getTemporaryDirectory();
  }

  static String getPluginPath(String plugin) {
    return join(Directory.current.path, "assets", "plugins", plugin);
  }

  static String getVCCSDirectory() {
    return join(applicationDocumentsDirectory.path, "VCCS");
  }

  static String getConfigurationPath() {
    return join(getVCCSDirectory(), "conf.json");
  }

  static String getProjectsDirectory() {
    return join(applicationDocumentsDirectory.path, "VCCS", "projects");
  }

  static String getSetsFolderPath(Project project) {
    return join(project.location, project.name, "sets");
  }

  static String getSetFolderPath(Project project, VCCSSet set) {
    return join(getSetsFolderPath(project), set.uid);
  }

  static String getRawImagesFolderPath(Project project, VCCSSet set) {
    return join(getSetFolderPath(project, set), "raw");
  }

  static String getRawImagePath(Project project, VCCSSet set, Slot slot) {
    return join(getRawImagesFolderPath(project, set), slot.id + ".jpg");
  }

  static String getProcessedImagesFolderPath(Project project, VCCSSet set) {
    return join(getSetFolderPath(project, set), "processed");
  }

  static String getRawThumbnailImagesFolderPath(Project project, VCCSSet set) {
    return join(getSetFolderPath(project, set), ".raw_thumb");
  }

  static String getProcessedThumbnailImagesFolderPath(
      Project project, VCCSSet set) {
    return join(getSetFolderPath(project, set), ".processed_thumb");
  }
}
