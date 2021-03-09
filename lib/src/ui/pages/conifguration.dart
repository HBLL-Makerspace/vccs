import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vccs/src/blocs/camera_bloc/camera_bloc.dart';
import 'package:vccs/src/model/backend/backend.dart';
import 'package:vccs/src/ui/route.gr.dart';
import 'package:vccs/src/ui/widgets/cards.dart';

class ConfigurationPage extends StatelessWidget {
  Widget _slotHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Slots",
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      ],
    );
  }

  Widget _cameraHeader(BuildContext context, String cameras) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Cameras: $cameras",
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              BlocProvider.of<CameraBloc>(context).add(LoadCamerasEvent());
            },
          ),
        )
      ],
    );
  }

  Widget _unassignedCameraHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Unassigned Cameras",
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {},
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configuration"),
      ),
      body: BlocBuilder<CameraBloc, CameraState>(
        builder: (context, state) {
          return Scrollbar(
            child: ListView(
              children: [
                _slotHeader(context),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Wrap(
                    children: [
                      ...DummyData.slots
                          .map((e) => SlotConfigCard(
                                slot: e,
                              ))
                          .toList()
                    ],
                  ),
                ),
                _cameraHeader(
                    context,
                    (state is CamerasState)
                        ? state.cameras.length.toString()
                        : "Loading"),
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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Wrap(
                      children: [
                        ...state.cameras
                            .map((e) => CameraCard(
                                  camera: e,
                                  onPressed: () {
                                    ExtendedNavigator.of(context).push(
                                        "/configure/cameras",
                                        arguments:
                                            CameraPageArguments(camera: e));
                                  },
                                ))
                            .toList()
                      ],
                    ),
                  ),
                // _unassignedCameraHeader(context),
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: Wrap(
                //     children: [
                //       ...DummyData.cameras
                //           .map((e) => CameraCard(
                //                 camera: e,
                //               ))
                //           .toList()
                //     ],
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
