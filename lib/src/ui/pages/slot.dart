import 'package:auto_route/auto_route.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:vccs/src/blocs/camera_bloc/camera_bloc.dart';
import 'package:vccs/src/blocs/configuration_bloc/configuration_bloc.dart';
import 'package:vccs/src/globals.dart';
import 'package:vccs/src/model/backend/backend.dart';
import 'package:vccs/src/model/backend/interfaces/camera_interface.dart';
import 'package:vccs/src/model/backend/interfaces/interfaces.dart';
import 'package:vccs/src/model/domain/configuration.dart';
import 'package:vccs/src/ui/widgets/forms/select_camera_property.dart';
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
  ICamera camera;

  @override
  void initState() {
    super.initState();
    slot = widget.slot;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller
        .getCameraByID(slot?.cameraRef?.cameraId)
        .then((value) => setState(() => camera = value));
  }

  Widget _header(BuildContext context, ICameraController controller,
      bool isChanging, bool isLiveView) {
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
                            Text(isLiveView ? "Stop" : "LiveView"),
                          ],
                        ),
                        onPressed: (isChanging && !isLiveView)
                            ? null
                            : () {
                                isLiveView
                                    ? BlocProvider.of<CameraBloc>(context,
                                            listen: false)
                                        .add(StopLiveView(camera))
                                    : BlocProvider.of<CameraBloc>(context,
                                            listen: false)
                                        .add(StartLiveView(camera));
                              }),
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

  Widget _camProperty(ICamera camera, CameraProperty property, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: CameraPropertyWidget(
              cameraProperty: property,
              overrideValue: slot.getCameraProperty(property.name).value,
              camera: camera,
              onUpdate: (value) {
                setState(() {
                  slot.setCameraProperty(value);
                  slot = slot.copyWith();
                });
                context
                    .read<ConfigurationBloc>()
                    .add(ConfigurationUpdateSlotEvent(slot));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  slot.removeCameraProperty(property);
                  slot = slot.copyWith();
                });
                context
                    .read<ConfigurationBloc>()
                    .add(ConfigurationUpdateSlotEvent(slot));
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _cameraSettings(BuildContext context, String cameraId) {
    if (camera != null)
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Camera Properties",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            ...(slot.config?.entries ?? {})
                .map((e) => _camProperty(
                    camera, camera.getProperty(e.value.name), e.value.value))
                ?.toList(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: VCCSRaisedButton(
                      child: Text("Add Property"),
                      onPressed: () async {
                        CameraProperty camProp =
                            await showFloatingModalBottomSheet(
                                context: context,
                                builder: (_) => SelectCameraProperty(
                                      camera: camera,
                                    ));
                        if (camProp != null) {
                          setState(() {
                            slot.setCameraProperty(camProp);
                            slot = slot.copyWith();
                          });
                          context
                              .read<ConfigurationBloc>()
                              .add(ConfigurationUpdateSlotEvent(slot));
                        }
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    else
      return Container();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraBloc, CameraState>(
        bloc: CameraBloc(),
        builder: (context, state) {
          if (state is CameraDataState) {
            return Scaffold(
              body: Scrollbar(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    _header(context, controller, !state.status.canInteract,
                        state.status.isLiveViewActive),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(),
                    ),
                    _cameraSettings(context, slot?.cameraRef?.cameraId)
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
