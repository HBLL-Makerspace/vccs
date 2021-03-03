import 'package:flutter/material.dart';
import 'package:vccs/src/model/domain/domian.dart';
import 'package:vccs/src/ui/widgets/widgets.dart';

class CameraSetup extends StatefulWidget {
  @override
  _CameraSetupState createState() => _CameraSetupState();
}

class _CameraSetupState extends State<CameraSetup> {
  final List<Slot> _slots = [
    Slot(
        id: "1",
        camera: Camera(id: "D3435", model: "D300"),
        status: Status.CONNECTED),
    Slot(
        id: "2",
        camera: Camera(id: "D3436", model: "D300"),
        status: Status.CONNECTED),
    Slot(
        id: "3",
        camera: Camera(id: "D3437", model: "D300"),
        status: Status.CONNECTED),
    Slot(
        id: "4",
        camera: Camera(id: "D3438", model: "D300"),
        status: Status.CONNECTING),
    Slot(
        id: "5",
        camera: Camera(id: "D3439", model: "D300"),
        status: Status.CONNECTING),
    Slot(
        id: "6",
        camera: Camera(id: "D3440", model: "D300"),
        status: Status.CONNECTING),
    Slot(
        id: "7",
        camera: Camera(id: "D3441", model: "D300"),
        status: Status.CONNECTING),
    Slot(
        id: "8",
        camera: Camera(id: "D3442", model: "D300"),
        status: Status.NOT_CONNECTED),
    Slot(
        id: "9",
        camera: Camera(id: "D3443", model: "D300"),
        status: Status.NOT_CONNECTED),
    Slot(
        id: "10",
        camera: Camera(id: "D3444", model: "D300"),
        status: Status.NOT_CONNECTED),
  ];

  Map<String, bool> _selected;

  @override
  void initState() {
    super.initState();
    _selected = {};
  }

  Widget _cameraProperties(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AdvancedCard(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Camera Properties",
                style: Theme.of(context).textTheme.headline4,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: CameraPropertiesForm(
                  horizontal: true,
                  actionLabel: _selected.containsValue(true)
                      ? "Apply to selected"
                      : "Apply to all",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _slotGridList() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: [
          ..._slots
              .map((e) => SlotCard(
                    slot: e,
                    showCheckbox: true,
                    isChecked: (_selected[e.id] ?? false),
                    onCheckboxClicked: (val) => setState(() {
                      _selected[e.id] = val;
                    }),
                    onPressed: () {
                      if (_selected.containsValue(true)) {
                        setState(() {
                          _selected[e.id] = !(_selected[e.id] ?? false);
                        });
                      }
                    },
                  ))
              .toList()
        ],
      ),
    );
  }

  Widget _select(BuildContext context) {
    bool _selectedAll = !_selected.containsValue(true)
        ? false
        : (_selected.length == _slots.length && !_selected.containsValue(false))
            ? true
            : null;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Checkbox(
            activeColor: Theme.of(context).accentColor,
            value: _selectedAll,
            onChanged: (val) => setState(() {
              _slots.forEach((element) {
                _selected[element.id] = val ?? false;
              });
            }),
            tristate: true,
          ),
          Text(!(_selectedAll ?? true) ? "Select All" : "Unselect All")
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _cameraProperties(context),
        _select(context),
        _slotGridList(),
      ],
    );
  }
}
