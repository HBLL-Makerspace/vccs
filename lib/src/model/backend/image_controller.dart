import 'dart:io';
import 'dart:isolate';
import 'package:image/image.dart';
import 'package:path/path.dart';
import 'package:vccs/src/model/backend/path_provider.dart';
import 'package:vccs/src/model/domain/configuration.dart';
import 'package:vccs/src/model/domain/project.dart';
import 'package:vccs/src/model/domain/set.dart';

class ImageController {
  Future<Image> generateThumbnailFor(String filename) async {}

  Future<File> getRawThumbnailFileForSlot(
      Project project, VCCSSet set, Slot slot) async {
    File file = File(join(
        PathProvider.getRawThumbnailImagesFolderPath(project, set),
        "${slot.id}.jpg"));
    if (file.existsSync())
      return file;
    else
      return null;
  }

  Future<Image> loadImage(File image) async {
    return decodeJpg(await image.readAsBytes());
  }
}
