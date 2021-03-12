import 'package:auto_route/auto_route.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vccs/src/blocs/camera_change_property/camera_change_property_bloc.dart';
import 'package:vccs/src/model/backend/implementations/camera_properties.dart';
import 'package:vccs/src/model/backend/interfaces/camera_interface.dart';
import 'package:vccs/src/ui/widgets/widgets.dart';

class CameraPage extends StatefulWidget {
  final ICamera camera;

  const CameraPage({Key key, @required this.camera}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  Map<String, CameraProperty> properties;
  CameraChangePropertyBloc bloc;

  @override
  void initState() {
    super.initState();
    properties = {};
  }

  Widget _header(BuildContext context, bool isChanging) {
    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: CameraCard(
                camera: widget.camera,
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
                      widget.camera.getModel(),
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  Text(
                    "Identification: ${widget.camera.getId()}",
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
                      child: Text("LiveView"),
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: VCCSFlatButton(
                      child: Text("Preview"),
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: VCCSRaisedButton(
                      child: Text("AutoFocus"),
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: VCCSRaisedButton(
                      child: Text("Capture"),
                      onPressed: () {},
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
      BuildContext context, String section, bool isChanging) {
    return Column(
      children: [
        ...widget.camera.getPropertiesInSection(section).map((e) => Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CameraPropertyWidget(
                enabled: !isChanging,
                cameraProperty: e,
                camera: widget.camera,
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

  Widget _camProperties(BuildContext context, bool isChanging) {
    return ExpandableTheme(
      data: ExpandableThemeData(
        iconColor: Colors.grey[300],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ...widget.camera.getSections().map((e) => Column(
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
                          child: _camSectionProperties(context, e, isChanging),
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

  Widget _page(BuildContext context) {
    return BlocBuilder<CameraChangePropertyBloc, CameraChangePropertyState>(
      cubit: bloc,
      builder: (context, state) {
        bool isChanging;
        if (state is ChangingCameraPropertyState) {
          isChanging = true;
        } else {
          isChanging = false;
        }
        return Scaffold(
          body: Scrollbar(
            child: ListView(
              children: [
                _header(context, isChanging),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _camProperties(context, isChanging),
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
                          bloc.add(ChangeCameraPropertyEvent(
                              widget.camera, properties.values.toList()));
                        },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bloc = CameraChangePropertyBloc(AppData.of(context).controller);
    return _page(context);
  }
}
