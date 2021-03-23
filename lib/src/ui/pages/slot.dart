import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:vccs/src/blocs/camera_bloc/camera_bloc.dart';
import 'package:vccs/src/blocs/configuration_bloc/configuration_bloc.dart';
import 'package:vccs/src/model/backend/interfaces/camera_interface.dart';
import 'package:vccs/src/model/backend/interfaces/interfaces.dart';
import 'package:vccs/src/model/domain/configuration.dart';
import 'package:vccs/src/ui/widgets/misc/color_picker.dart';
import 'package:vccs/src/ui/widgets/widgets.dart';

class SlotPage extends StatefulWidget {
  final Slot slot;

  const SlotPage({Key key, @required this.slot}) : super(key: key);

  @override
  _SlotPageState createState() => _SlotPageState();
}

class _SlotPageState extends State<SlotPage> {
  Slot slot;

  @override
  void initState() {
    super.initState();
    slot = widget.slot;
  }

  Widget _header(BuildContext context, ICameraController controller) {
    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: CameraCard(
                cameraRef: slot.cameraRef,
                onPressed: () {
                  ExtendedNavigator.of(context)
                      .push("/configure/cameras/${slot.cameraRef.cameraId}");
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 62.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, bottom: 4.0),
                        child: ColorIndicator(
                          width: 52,
                          height: 52,
                          borderRadius: 4,
                          color: Color(slot.color),
                          onSelect: () async {
                            Color colorPicked = Color(slot.color);
                            bool picked = await colorPickerDialog(
                                context, Color(slot.color), (col) {
                              colorPicked = col;
                            });
                            if (picked) {
                              setState(() {
                                slot = slot.copyWith(color: colorPicked.value);
                              });
                              context
                                  .read<ConfigurationBloc>()
                                  .add(ConfigurationUpdateSlotEvent(slot));
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Slot: ${slot.name}",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                    ],
                  ),
                  if (slot.cameraRef != null)
                    Text(
                      "${slot.cameraRef?.cameraModel}: ${slot.cameraRef?.cameraId}",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                ],
              ),
            ),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconButton(
                icon: Icon(Ionicons.ios_arrow_back),
                onPressed: () => ExtendedNavigator.of(context).pop(),
              ),
            )
          ],
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: VCCSFlatButton(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 8.0, bottom: 1.0),
                              child: Icon(
                                Ionicons.md_videocam,
                                size: 16,
                              ),
                            ),
                            Text("Liveview"),
                          ],
                        ),
                        onPressed: () {}
                        /*
                      ? null : ()
                      {
                        
                        BlocProvider.of<ConfigurationBloc>(context,
                        listen: false).add(ConfigurationStartLiveViewEvent(controller.getCameraByID(slot.cameraRef.cameraId)));
                      }
                      */
                        ),
                  ),
                  if (slot.cameraRef != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: VCCSFlatButton(
                        child: Text("Unassign"),
                        onPressed: () {
                          setState(() {
                            slot = slot.unassign();
                          });
                          context
                              .read<ConfigurationBloc>()
                              .add(ConfigurationUpdateSlotEvent(slot));
                        },
                        hoverColor: Colors.red[400],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: VCCSRaisedButton(
                      child: Text(slot.cameraRef != null
                          ? "Reassign Camera"
                          : "Assign Camera"),
                      onPressed: () async {
                        var cam = await showFloatingModalBottomSheet<ICamera>(
                            context: context, builder: (_) => SelectCamera());

                        if (cam != null) {
                          setState(() {
                            slot = slot.copyWith(
                                cameraRef:
                                    CameraRef(cam.getId(), cam.getModel()));
                          });
                          context
                              .read<ConfigurationBloc>()
                              .add(ConfigurationUpdateSlotEvent(slot));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var _controller = AppData.of(context).controller;
    return Scaffold(
      body: Scrollbar(
        child: ListView(
          children: [
            _header(context, _controller),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
