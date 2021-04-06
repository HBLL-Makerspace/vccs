import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vccs/src/blocs/search_camera_property/search_camera_property_bloc.dart';
import 'package:vccs/src/model/backend/backend.dart';
import 'package:vccs/src/ui/widgets/textfield.dart';

class SelectCameraProperty extends StatelessWidget {
  final ICamera camera;
  const SelectCameraProperty({Key key, this.camera}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchCameraPropertyBloc bloc = SearchCameraPropertyBloc(camera);
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 500,
        maxHeight: 400,
      ),
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: VCCSTextFormField(
                label: "Search",
                onChanged: (val) =>
                    {bloc.add(SearchCameraPropertiesEvent(val))},
                onSubmitted: (val) =>
                    {bloc.add(SearchCameraPropertiesEvent(val))},
              ),
            ),
            Expanded(
              child: Scrollbar(
                child: BlocBuilder<SearchCameraPropertyBloc,
                    SearchCameraPropertyState>(
                  bloc: bloc,
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case SearchCameraPropertyDateState:
                        var typed = state as SearchCameraPropertyDateState;
                        return ListView(
                          shrinkWrap: true,
                          children: [
                            ...typed.results
                                .map((e) => ListTile(
                                      title: Text(e.label ?? "Unknown"),
                                      subtitle: Text(e.name ?? "Unknown"),
                                      trailing: Text(e.type
                                          .toString()
                                          .split(".")[1]
                                          .toLowerCase()),
                                      onTap: () {
                                        Navigator.pop(context, e);
                                      },
                                    ))
                                .toList()
                          ],
                        );
                      case SearchCameraPropertySearchingState:
                        return Center(
                          child: SpinKitWave(
                            size: 24,
                            color: Colors.white,
                          ),
                        );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
