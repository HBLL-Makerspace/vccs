import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vccs/src/blocs/multi_camera_bloc/camera_bloc.dart';
import 'package:vccs/src/blocs/configuration_bloc/configuration_bloc.dart';
import 'package:vccs/src/model/domain/configuration.dart';
import 'package:vccs/src/ui/route.gr.dart';
import 'package:vccs/src/ui/widgets/buttons.dart';
import 'package:vccs/src/ui/widgets/cards.dart';
import 'package:vccs/src/ui/widgets/forms/create_slot.dart';

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
              BlocProvider.of<MultiCameraBloc>(context).add(LoadCamerasEvent());
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

  Widget _addSlotButton(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DottedBorder(
          dashPattern: [5, 10],
          strokeWidth: 3,
          strokeCap: StrokeCap.round,
          borderType: BorderType.RRect,
          radius: Radius.circular(16),
          color: Theme.of(context).primaryColor,
          child: Material(
            borderRadius: BorderRadius.circular(16),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () async {
                Slot slot = await showDialog(
                    context: context, builder: (context) => CreateSlotForm());
                if (slot.name != null)
                  context
                      .read<ConfigurationBloc>()
                      .add(ConfigurationAddSlotEvent(slot));
              },
              child: Container(
                height: 200,
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _slots(BuildContext context) {
    return BlocBuilder<ConfigurationBloc, ConfigurationState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case ConfigurationInitial:
            return Row(
              children: [Text("Configuration not loaded. Please restart app.")],
            );
          case ConfigurationDataState:
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                children: [
                  ...(state as ConfigurationDataState)
                      .configuration
                      .getSlots()
                      .map((e) => SlotConfigCard(
                            slot: e,
                            onPressed: () => ExtendedNavigator.of(context).push(
                                "/configure/slots",
                                arguments: SlotPageArguments(slot: e)),
                          ))
                      .toList(),
                  _addSlotButton(context)
                ],
              ),
            );
          default:
            return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configuration"),
        actions: [
          VCCSRaisedButton(
            child: Text("Save"),
            onPressed: () {
              BlocProvider.of<ConfigurationBloc>(context)
                  .add(SaveConfigurationEvent());
            },
          ),
        ],
      ),
      body: BlocBuilder<MultiCameraBloc, CameraState>(
        builder: (context, state) {
          return Scrollbar(
            child: ListView(
              children: [
                _slotHeader(context),
                _slots(context),

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
                                        "/configure/cameras/${e.getId()}");
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
