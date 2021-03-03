import 'package:flutter/material.dart';
import 'package:vccs/src/model/backend/backend.dart';
import 'package:vccs/src/ui/widgets/buttons.dart';
import 'package:vccs/src/ui/widgets/cards.dart';
import 'package:vccs/src/ui/widgets/textfield.dart';

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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: VCCSTextFormField(
              label: "Number of slots",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: VCCSRaisedButton(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Text("Set"),
            ),
          ),
        )
      ],
    );
  }

  Widget _cameraHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Cameras",
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
      body: Scrollbar(
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
            _cameraHeader(context),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                children: [
                  ...DummyData.cameras
                      .map((e) => CameraCard(
                            camera: e,
                          ))
                      .toList()
                ],
              ),
            ),
            _unassignedCameraHeader(context),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                children: [
                  ...DummyData.cameras
                      .map((e) => CameraCard(
                            camera: e,
                          ))
                      .toList()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
