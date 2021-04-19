import 'package:flutter/material.dart';
import 'package:vccs/src/ui/widgets/textfield.dart';
import 'package:vccs/src/ui/pages/subpages/set.dart';
import 'package:vccs/src/ui/widgets/buttons.dart';

class ModelCreation extends StatefulWidget {
  @override
  ModelCreationState createState() => new ModelCreationState();
}

class MyData {
  String hostAddress;
  String portNumber;
}

class ModelCreationState extends State<ModelCreation> {
  int currentStep = 0;
  TextEditingController hostController = new TextEditingController();
  TextEditingController portController = new TextEditingController();
  static MyData data = new MyData();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Stepper(
              type: StepperType.horizontal,
              physics: ScrollPhysics(),
              onStepTapped: (step) => tapped(step),
              controlsBuilder: (BuildContext context,
                      {VoidCallback onStepContinue,
                      VoidCallback onStepCancel}) =>
                  SizedBox.shrink(),
              steps: [
                Step(
                  title: new Text('Connect to 3D Software'),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: VCCSTextFormField(
                          label: "Enter the target host address",
                          //onSubmitted: update data
                        ),
                      ),
                      Container(
                          child: VCCSTextFormField(
                        label: "Enter the target port number",
                        //onSubmitted: update data
                      )),
                      Row(
                        children: [
                          VCCSFlatButton(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, bottom: 1.0),
                                  //child: Icon(),
                                ),
                                Text("Continue"),
                              ],
                            ),
                            onPressed: () {
                              continued();
                            },
                          ),
                          VCCSFlatButton(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, bottom: 1.0),
                                  //child: Icon(),
                                ),
                                Text("Cancel"),
                              ],
                            ),
                            onPressed: () {
                              cancel();
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                  isActive: currentStep >= 0,
                  state:
                      currentStep > 0 ? StepState.complete : StepState.disabled,
                ),
                Step(
                  title: new Text('Select Sets'),
                  //content: SetPage().build(context),
                  content: Column(
                    children: [
                      new Text("Temporary content"),
                      Row(
                        children: [
                          VCCSFlatButton(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, bottom: 1.0),
                                  //child: Icon(),
                                ),
                                Text("Continue"),
                              ],
                            ),
                            onPressed: () {
                              continued();
                            },
                          ),
                          VCCSFlatButton(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, bottom: 1.0),
                                  //child: Icon(),
                                ),
                                Text("Cancel"),
                              ],
                            ),
                            onPressed: () {
                              cancel();
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                  isActive: currentStep >= 1,
                  state:
                      currentStep > 1 ? StepState.complete : StepState.disabled,
                ),
                Step(
                  title: new Text('Create 3D Model'),
                  //Starts creating software, when done we can push the button to continue
                  content: Column(
                    children: [
                      new Text(
                          'This is where it will connect to external software'),
                      VCCSFlatButton(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 8.0, bottom: 1.0),
                            ),
                            Text("Create Model"),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PostCreation()));
                        },
                      ),
                    ],
                  ),

                  isActive: currentStep >= 2,
                  state: currentStep >= 2
                      ? StepState.complete
                      : StepState.disabled,
                ),
              ],
              currentStep: this.currentStep,
            )),
          ],
        ),
      ),
    );
  }

  tapped(int step) {
    setState(() => currentStep = step);
  }

  continued() {
    setState(() {
      if (this.currentStep < 2) {
        this.currentStep = this.currentStep + 1;
      }
    });
  }

  cancel() {
    setState(() {
      if (this.currentStep > 0) {
        this.currentStep = this.currentStep - 1;
      }
    });
  }
}

class PostCreation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //appbar info here
          ),
      body: Container(
        child: Text("Assembled model view will go here"),
      ),
    );
  }
}
