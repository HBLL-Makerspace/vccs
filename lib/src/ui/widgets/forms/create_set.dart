import 'package:flutter/material.dart';
import 'package:vccs/src/ui/widgets/buttons.dart';
import 'package:vccs/src/ui/widgets/textfield.dart';

class CreateSet extends StatelessWidget {
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
                  Navigator.of(context).pop();
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
