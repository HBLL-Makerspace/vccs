import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vccs/src/model/backend/implementations/camera_properties.dart';
import 'package:vccs/src/model/backend/interfaces/camera_interface.dart';
import 'package:string_similarity/string_similarity.dart';

part 'search_camera_property_event.dart';
part 'search_camera_property_state.dart';

class SearchCameraPropertyBloc
    extends Bloc<SearchCameraPropertyEvent, SearchCameraPropertyState> {
  SearchCameraPropertyBloc(this.camera)
      : super(SearchCameraPropertyDateState(
            camera.getPropertiesMap().values.toList()));
  final ICamera camera;

  @override
  Stream<SearchCameraPropertyState> mapEventToState(
    SearchCameraPropertyEvent event,
  ) async* {
    switch (event.runtimeType) {
      case SearchCameraPropertiesEvent:
        yield SearchCameraPropertySearchingState();
        List<CameraProperty> sorted = camera.getPropertiesMap().values.toList();
        var typed = event as SearchCameraPropertiesEvent;
        sorted.sort((a, b) => b.name
            .similarityTo(typed.search)
            .compareTo(a.name.similarityTo(typed.search)));
        yield SearchCameraPropertyDateState(sorted.sublist(0, 10));
        break;
    }
  }
}
