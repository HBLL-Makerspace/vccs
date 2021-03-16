import 'package:auto_route/auto_route.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vccs/src/blocs/camera_bloc/camera_bloc.dart';
import 'package:vccs/src/model/backend/implementations/camera_properties.dart';
import 'package:vccs/src/model/backend/interfaces/camera_interface.dart';
import 'package:vccs/src/ui/widgets/widgets.dart';

class CameraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var routeData = RouteData.of(context);
    var id = routeData.pathParams['id'].value;
    var _controller = AppData.of(context).controller;
    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) =>
            CameraBloc(_controller)..add(LoadCameraDataEvent(id)),
        child: _CameraPageInternal(),
      ),
    );
  }
}

class _CameraPageInternal extends StatefulWidget {
  const _CameraPageInternal({Key key}) : super(key: key);
  @override
  __CameraPageInternalState createState() => __CameraPageInternalState();
}

class __CameraPageInternalState extends State<_CameraPageInternal> {
  Map<String, CameraProperty> properties;

  @override
  void initState() {
    super.initState();
    properties = {};
  }

  Widget _header(BuildContext context, ICamera camera, bool isChanging) {
    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: CameraCard(
                camera: camera,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 62.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      camera.getModel(),
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  Text(
                    "Identification: ${camera.getId()}",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconButton(
                icon: Icon(Icons.close),
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
                            padding:
                                const EdgeInsets.only(right: 8.0, bottom: 1.0),
                            child: Icon(
                              Ionicons.md_videocam,
                              size: 16,
                            ),
                          ),
                          Text("LiveView"),
                        ],
                      ),
                      onPressed: isChanging ? null : () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: VCCSFlatButton(
                      child: Text("Preview"),
                      onPressed: isChanging ? null : () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: VCCSRaisedButton(
                      child: Text("AutoFocus"),
                      onPressed: isChanging ? null : () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: VCCSRaisedButton(
                      child: Text("Capture"),
                      onPressed: isChanging ? null : () {},
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

  Widget _camSectionProperties(
      BuildContext context, String section, ICamera camera, bool isChanging) {
    return Column(
      children: [
        ...camera.getPropertiesInSection(section).map((e) => Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CameraPropertyWidget(
                enabled: !isChanging,
                cameraProperty: e,
                camera: camera,
                onUpdate: (value) {
                  setState(() {
                    properties[value.name] = value;
                  });
                },
              ),
            ))
      ],
    );
  }

  Widget _camProperties(BuildContext context, ICamera camera, bool isChanging) {
    return ExpandableTheme(
      data: ExpandableThemeData(
        iconColor: Colors.grey[300],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ...camera.getSections().map((e) => Column(
                  children: [
                    Material(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: ExpandablePanel(
                        header: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            e,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        expanded: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: _camSectionProperties(
                              context, e, camera, isChanging),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget _search() {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 16.0, bottom: 0, left: 32, right: 32),
          child: VCCSTextFormField(
            label: "Search",
          ),
        )
      ],
    );
  }

  Widget _page(BuildContext context) {
    return BlocBuilder<CameraBloc, CameraChangePropertyState>(
        builder: (context, state) {
      if (state is CameraDataState) {
        bool isChanging = !state.status.canInteract;
        return Scaffold(
          body: Scrollbar(
            child: ListView(
              children: [
                _header(context, state.camera, isChanging),
                _search(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _camProperties(context, state.camera, isChanging),
                ),
                Container(
                  height: 80,
                )
              ],
            ),
          ),
          floatingActionButton: AnimatedOpacity(
            opacity: properties.isEmpty ? 0 : 1,
            duration: Duration(milliseconds: 300),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: VCCSFlatButton(
                    hoverColor: Colors.red[400],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Cancel"),
                    ),
                    onPressed: isChanging
                        ? null
                        : () {
                            setState(() {
                              properties.clear();
                            });
                          },
                  ),
                ),
                VCCSRaisedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isChanging
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(
                              height: 15,
                              child: SpinKitWave(
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          )
                        : Text("Apply Changes"),
                  ),
                  onPressed: isChanging
                      ? null
                      : () {
                          BlocProvider.of<CameraBloc>(context, listen: false)
                              .add(ChangeCameraPropertyEvent(
                                  state.camera, properties.values.toList()));
                        },
                ),
              ],
            ),
          ),
        );
      } else
        return Scaffold(
          body: Center(child: Text("loading camera")),
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return _page(context);
  }
}
