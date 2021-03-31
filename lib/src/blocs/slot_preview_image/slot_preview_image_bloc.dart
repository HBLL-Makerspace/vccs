import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image/image.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:vccs/src/model/backend/image_controller.dart';
import 'package:vccs/src/model/backend/path_provider.dart';
import 'package:vccs/src/model/domain/configuration.dart';
import 'package:vccs/src/model/domain/project.dart';
import 'package:vccs/src/model/domain/set.dart';
import 'package:watcher/watcher.dart';

part 'slot_preview_image_event.dart';
part 'slot_preview_image_state.dart';

class SlotPreviewImageBloc
    extends Bloc<SlotPreviewImageEvent, SlotPreviewImageState> {
  SlotPreviewImageBloc(this.project, this.set, this.slot)
      : super(SlotPreviewImageInitial()) {
    if (!Directory(join(PathProvider.getRawImagesFolderPath(project, set),
            "${slot.id}.TMP"))
        .existsSync()) {
      print("Got temp file");
      add(LoadSlotPreviewImageEvent());
    }
    DirectoryWatcher(PathProvider.getRawImagesFolderPath(project, set))
        .events
        .listen((event) {
      if (basename(event.path) == slot.id + ".TMP") {
        if (event.type == ChangeType.ADD) {
          add(TempFilePictureAddedEvent());
        }
        if (event.type == ChangeType.REMOVE) {
          add(TempFilePictureRemovedEvent());
        }
      }
    });
  }

  final Project project;
  final VCCSSet set;
  final Slot slot;

  @override
  Stream<SlotPreviewImageState> mapEventToState(
    SlotPreviewImageEvent event,
  ) async* {
    switch (event.runtimeType) {
      case LoadSlotPreviewImageEvent:
        yield LoadingSlotPreviewImageState();
        var typed = event as LoadSlotPreviewImageEvent;
        if (Directory(join(PathProvider.getRawImagesFolderPath(project, set),
                "${slot.id}.TMP"))
            .existsSync()) {
          LoadingSlotPreviewImageState();
        } else {
          ImageController controller = ImageController();
          yield LoadedSlotPreviewImageState(
              await controller.getRawThumbnailFileForSlot(project, set, slot));
        }
        break;
      case TempFilePictureAddedEvent:
        yield LoadingSlotPreviewImageState();
        break;
      case TempFilePictureRemovedEvent:
        ImageController controller = ImageController();
        yield LoadedSlotPreviewImageState(
            await controller.getRawThumbnailFileForSlot(project, set, slot));
        break;
    }
  }
}
