part of 'search_camera_property_bloc.dart';

@immutable
abstract class SearchCameraPropertyState {}

class SearchCameraPropertySearchingState extends SearchCameraPropertyState {}

class SearchCameraPropertyDateState extends SearchCameraPropertyState {
  final List<CameraProperty> results;

  SearchCameraPropertyDateState(this.results);
}
