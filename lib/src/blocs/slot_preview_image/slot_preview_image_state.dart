part of 'slot_preview_image_bloc.dart';

@immutable
abstract class SlotPreviewImageState {}

class SlotPreviewImageInitial extends SlotPreviewImageState {}

class LoadingSlotPreviewImageState extends SlotPreviewImageState {}

class LoadedSlotPreviewImageState extends SlotPreviewImageState {
  final File file;

  LoadedSlotPreviewImageState(this.file);
}
