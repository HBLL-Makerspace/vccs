// import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vccs/src/ui/widgets/buttons.dart';
import 'package:vccs/src/ui/widgets/textfield.dart';

class CreateSlotForm extends StatefulWidget {
  @override
  _CreateSlotFormState createState() => _CreateSlotFormState();
}

class _CreateSlotFormState extends State<CreateSlotForm> {
  FocusNode _node;
  TextEditingController _controller;

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
    else
      Navigator.pop(context, _controller.text);
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
