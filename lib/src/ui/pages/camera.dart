import 'package:auto_route/auto_route.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vccs/src/model/backend/interfaces/camera_interface.dart';
import 'package:vccs/src/ui/widgets/widgets.dart';

class CameraPage extends StatelessWidget {
  final ICamera camera;

  const CameraPage({Key key, @required this.camera}) : super(key: key);

  Widget _header(BuildContext context) {
    return Row(
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
    );
  }

  Widget _camSectionProperties(BuildContext context, String section) {
    return Column(
      children: [
        ...camera.getPropertiesInSection(section).map((e) => Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CameraPropertyWidget(
                cameraProperty: e,
                camera: camera,
              ),
            ))
      ],
    );
  }

  Widget _camProperties(BuildContext context) {
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
                          child: _camSectionProperties(context, e),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: ListView(
          children: [
            _header(context),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _camProperties(context),
            )
          ],
        ),
      ),
    );
  }
}
