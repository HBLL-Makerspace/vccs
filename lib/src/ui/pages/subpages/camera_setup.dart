import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vccs/src/blocs/configuration_bloc/configuration_bloc.dart';
import 'package:vccs/src/model/domain/domian.dart';
import 'package:vccs/src/ui/widgets/widgets.dart';

class CameraSetup extends StatefulWidget {
  @override
  _CameraSetupState createState() => _CameraSetupState();
}

class _CameraSetupState extends State<CameraSetup> {
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

  Widget _slotGridList(List<Slot> _slots) {
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
                      // if (_selected.containsValue(true)) {
                      setState(() {
                        _selected[e.id] = !(_selected[e.id] ?? false);
                      });
                      // }
                    },
                  ))
              .toList()
        ],
      ),
    );
  }

  Widget _select(BuildContext context, List<Slot> _slots) {
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
    return BlocBuilder<ConfigurationBloc, ConfigurationState>(
      builder: (context, state) {
        if (state is ConfigurationDataState) {
          List<Slot> _slots = state.configuration.getSlots();
          return ListView(
            children: [
              _cameraProperties(context),
              _select(context, _slots),
              _slotGridList(_slots),
            ],
          );
        } else
          return Center(
            child: SpinKitWave(color: Colors.white),
          );
      },
    );
  }
}
