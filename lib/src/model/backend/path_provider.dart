import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

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
}
