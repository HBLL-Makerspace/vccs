part of 'slot_preview_image_bloc.dart';

@immutable
abstract class SlotPreviewImageEvent {}

class LoadSlotPreviewImageEvent extends SlotPreviewImageEvent {
  final Project project;
  final VCCSSet set;
  final Slot slot;

  LoadSlotPreviewImageEvent(this.project, this.set, this.slot);
}
