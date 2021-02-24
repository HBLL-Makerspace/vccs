import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vccs/src/ui/widgets/buttons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:vccs/src/ui/widgets/forms/create_project.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Text(
                "V Camera Control Software",
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: VCCSRaisedButton(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Create Project"),
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => CreateProjectForm());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: VCCSRaisedButton(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Open Project"),
                            ),
                            onPressed: () {
                              // ExtendedNavigator.of(context).push("/project");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FilePicker()));
                              // ExtendedNavigator.of(context).push("/project");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: VCCSRaisedButton(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Configure"),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
