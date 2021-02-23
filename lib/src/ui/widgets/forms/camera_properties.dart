import 'package:flutter/material.dart';
import 'package:vccs/src/model/domain/configuration.dart';
import 'package:vccs/src/ui/widgets/buttons.dart';
import 'package:vccs/src/ui/widgets/textfield.dart';

class CameraPropertiesForm extends StatelessWidget {
  final bool horizontal;
  final String actionLabel;
  final ValueChanged<CameraProperties> onSubmit;

  const CameraPropertiesForm(
      {Key key,
      this.horizontal = false,
      this.actionLabel = "Apply",
      this.onSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _key = GlobalKey<FormState>();
    return Form(
        child: Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: VCCSTextFormField(label: "ISO"),
            )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: VCCSTextFormField(label: "Aperture"),
            )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: VCCSTextFormField(label: "Shutter"),
            )),
            Expanded(child: VCCSTextFormField(label: "Exposure Compensation"))
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              VCCSRaisedButton(
                onPressed: () {},
                child: Text(actionLabel),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
