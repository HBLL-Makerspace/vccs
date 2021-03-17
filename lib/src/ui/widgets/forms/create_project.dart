// import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vccs/src/blocs/create_project/create_project_bloc.dart';
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
  TextEditingController _name;
  CreateProjectBloc bloc;
  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _node = FocusNode();
    _node.requestFocus();
    _location =
        TextEditingController(text: PathProvider.getProjectsDirectory());
    _name = TextEditingController();
    bloc = CreateProjectBloc();
    _formKey = GlobalKey<FormState>();
  }

  Widget _form(BuildContext context, state) {
    bool isCreating = state is CreatingNewProjectState;
    return Form(
      key: _formKey,
      child: Container(
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
                    enabled: !isCreating,
                    focusNode: _node,
                    label: "Project name",
                    controller: _name,
                    validator: (name) {
                      return null;
                      RegExp exp = RegExp(r"@'^[\w\-. ]+$'");
                      if (exp.stringMatch(name) != null) {
                        return null;
                      } else
                        return "Not a valid name";
                    },
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
                          enabled: false && !isCreating,
                          controller: _location,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: VCCSFlatButton(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text("Browse"),
                          ),
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
                          child: isCreating
                              ? SpinKitWave(size: 24, color: Colors.white)
                              : Text("Create"),
                          onPressed: isCreating ? null : submit,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submit() {
    if (_formKey.currentState.validate())
      bloc.add(CreateNewProjectEvent(_name.text, _location.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateProjectBloc, CreateProjectState>(
      cubit: bloc,
      listener: (context, state) {
        if (state is CreatedNewProjectState) Navigator.pop(context);
      },
      child: BlocBuilder<CreateProjectBloc, CreateProjectState>(
        cubit: bloc,
        builder: (context, state) {
          return _form(context, state);
        },
      ),
    );
  }
}
