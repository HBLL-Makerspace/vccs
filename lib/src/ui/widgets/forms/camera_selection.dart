import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vccs/src/blocs/configuration_bloc/configuration_bloc.dart';
import 'package:vccs/src/blocs/multi_camera_bloc/camera_bloc.dart';
import 'package:vccs/src/model/domain/camera_config.dart';
import 'package:vccs/src/ui/widgets/inherited.dart';
import 'package:vccs/src/ui/widgets/textfield.dart';

class SelectCamera extends StatelessWidget {
  final bool filter;

  const SelectCamera({Key key, this.filter = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> assignedCameras = context
        .read<ConfigurationBloc>()
        .configuration
        .getAssignedCameraRefs()
        .map((e) => e?.cameraId)
        .toList();
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
              ),
            ),
            Expanded(
              child: Scrollbar(
                child: BlocBuilder<MultiCameraBloc, CameraState>(
                  builder: (context, state) {
                    return ListView(
                      shrinkWrap: true,
                      children: [
                        if (state is LoadingCamerasState)
                          Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Row(children: [
                              Expanded(
                                child: SpinKitWave(
                                  color: Colors.grey[300],
                                ),
                              )
                            ]),
                          ),
                        if (state is CamerasState)
                          ...state.cameras
                              .where((cam) =>
                                  !assignedCameras.contains(cam.getId()))
                              .map((e) => ListTile(
                                    title: Text(e.getModel() ?? "Unknown"),
                                    subtitle: Text(e.getId() ?? "Unknown"),
                                    leading: Image(
                                      image: AssetImage(CameraConfiguration
                                          .getSmallThumbnailFor(e.getModel())),
                                    ),
                                    onTap: () {
                                      Navigator.pop(context, e);
                                    },
                                  ))
                              .toList()
                      ],
                    );
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
