// import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:vccs/src/model/domain/configuration.dart';
import 'package:vccs/src/ui/widgets/buttons.dart';
import 'package:vccs/src/ui/widgets/misc/color_picker.dart';
import 'package:vccs/src/ui/widgets/textfield.dart';

class CreateSlotForm extends StatefulWidget {
  @override
  _CreateSlotFormState createState() => _CreateSlotFormState();
}

class _CreateSlotFormState extends State<CreateSlotForm> {
  FocusNode _node;
  TextEditingController _controller;
  Color slotColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    _node = FocusNode();
    _node.requestFocus();
    _controller = TextEditingController();
  }

  void submit() {
    if (_controller.text == null || _controller.text.isEmpty)
      Navigator.pop(context);
    else {
      Navigator.pop(
          context, Slot(name: _controller.text, color: slotColor.value));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 500),
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Create Slot",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: VCCSTextFormField(
                  focusNode: _node,
                  label: "Slot name",
                  controller: _controller,
                  onSubmitted: (_) {
                    submit();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                child: ListTile(
                  title: Text("Slot color"),
                  subtitle: Text(
                      "Color of the slot, just a way to visually distinguish or group slots."),
                  trailing: ColorIndicator(
                    width: 44,
                    height: 44,
                    borderRadius: 4,
                    color: slotColor,
                    onSelect: () async {
                      Color colorPicked = slotColor;
                      bool picked =
                          await colorPickerDialog(context, slotColor, (col) {
                        colorPicked = col;
                      });
                      if (picked)
                        setState(() {
                          slotColor = colorPicked;
                        });
                    },
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: VCCSRaisedButton(
                        child: Text("Create"),
                        onPressed: submit,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
