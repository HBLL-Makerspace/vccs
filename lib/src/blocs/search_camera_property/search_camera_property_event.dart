part of 'search_camera_property_bloc.dart';

@immutable
abstract class SearchCameraPropertyEvent {}

class SearchCameraPropertiesEvent extends SearchCameraPropertyEvent {
  final String search;

  SearchCameraPropertiesEvent(this.search);
}
