part of 'slot_preview_image_bloc.dart';

@immutable
abstract class SlotPreviewImageEvent {}

class LoadSlotPreviewImageEvent extends SlotPreviewImageEvent {
  LoadSlotPreviewImageEvent();
}

class TempFilePictureAddedEvent extends SlotPreviewImageEvent {}

class TempFilePictureRemovedEvent extends SlotPreviewImageEvent {}
