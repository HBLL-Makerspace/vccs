import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image/image.dart';
import 'package:meta/meta.dart';
import 'package:vccs/src/model/backend/image_controller.dart';
import 'package:vccs/src/model/domain/configuration.dart';
import 'package:vccs/src/model/domain/project.dart';
import 'package:vccs/src/model/domain/set.dart';

part 'slot_preview_image_event.dart';
part 'slot_preview_image_state.dart';

class SlotPreviewImageBloc
    extends Bloc<SlotPreviewImageEvent, SlotPreviewImageState> {
  SlotPreviewImageBloc() : super(SlotPreviewImageInitial());

  @override
  Stream<SlotPreviewImageState> mapEventToState(
    SlotPreviewImageEvent event,
  ) async* {
    switch (event.runtimeType) {
      case LoadSlotPreviewImageEvent:
        yield LoadingSlotPreviewImageState();
        var typed = event as LoadSlotPreviewImageEvent;
        ImageController controller = ImageController();
        yield LoadedSlotPreviewImageState(await controller
            .getRawThumbnailForSlot(typed.project, typed.set, typed.slot));
        break;
    }
  }
}
