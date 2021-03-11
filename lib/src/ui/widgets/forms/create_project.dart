// import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'package:vccs/src/model/backend/path_provider.dart';
import 'package:vccs/src/ui/widgets/buttons.dart';
import 'package:vccs/src/ui/widgets/textfield.dart';

class CreateProjectForm extends StatefulWidget {
  @override
  _CreateProjectFormState createState() => _CreateProjectFormState();
}

class _CreateProjectFormState extends State<CreateProjectForm> {
  FocusNode _node;
  TextEditingController _location;

  @override
  void initState() {
    super.initState();
    _node = FocusNode();
    _node.requestFocus();
    _location =
        TextEditingController(text: PathProvider.getProjectsDirectory());
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
                  "Create Project",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: VCCSTextFormField(
                  focusNode: _node,
                  label: "Project name",
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: VCCSTextFormField(
                        label: "Location",
                        enabled: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: VCCSFlatButton(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text("Browse"),
                        ),
                        // onPressed: () async {
                        // show a dialog to open a file
                        // FilePickerCross myFile = await FilePickerCross.importFromStorage(
                        //     type: FileTypeCross.any, // Available: `any`, `audio`, `image`, `video`, `custom`. Note: not available using FDE
                        //     fileExtension: 'txt, md' // Only if FileTypeCross.custom . May be any file extension like `dot`, `ppt,pptx,odp`
                        //     );
                        // },
                      ),
                    )
                  ],
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
                        onPressed: () {},
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
