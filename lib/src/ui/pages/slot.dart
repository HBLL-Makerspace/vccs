import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vccs/src/model/backend/interfaces/camera_interface.dart';
import 'package:vccs/src/model/domain/configuration.dart';
import 'package:vccs/src/ui/widgets/widgets.dart';

class SlotPage extends StatelessWidget {
  final Slot slot;
  final ICamera camera;

  const SlotPage({Key key, @required this.slot, this.camera}) : super(key: key);

  Widget _header(BuildContext context) {
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
                      "Slot: ${slot.name}",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  if (slot.cameraRef != null)
                    Text(
                      "${slot.cameraRef?.cameraModel}: ${slot.cameraRef?.cameraId}",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  if (slot.cameraRef == null)
                    VCCSRaisedButton(
                      child: Text("Assign Camera"),
                      onPressed: () {},
                    )
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
      ],
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
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
