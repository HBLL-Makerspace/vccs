import 'package:flutter/material.dart';
import 'package:vccs/src/ui/widgets/widgets.dart';

class CreateSet extends StatefulWidget {
  @override
  _CreateSetState createState() => _CreateSetState();
}

class _CreateSetState extends State<CreateSet> {
  TextEditingController _name;
  FocusNode _node;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _node = FocusNode();
    _node.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Create Set",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: VCCSTextFormField(
            focusNode: _node,
            onSubmitted: (_) => Navigator.of(context).pop(_name.text),
            controller: _name,
            label: "Name",
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: VCCSRaisedButton(
                onPressed: () {
                  Navigator.of(context).pop(_name.text);
                },
                child: Text("Create"),
              ),
            ),
          ],
        )
      ],
    );
  }
}
