import 'package:flutter/material.dart';
import 'package:vccs/src/ui/widgets/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ModelCreation extends StatefulWidget {
  @override
  ModelCreationState createState() => new ModelCreationState();
}

class ModelCreationState extends State<ModelCreation> {
  @override
  final textController1 = TextEditingController();
  final textController2 = TextEditingController();
  int currentStep = 0;
  int hostAddress;
  int portNumber;
  bool isReadyToCreate;
  StepperType type = StepperType.horizontal;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Stepper(
              type: type,
              physics: ScrollPhysics(),
              currentStep: currentStep,
              onStepTapped: (step) => tapped(step),
              onStepContinue: continued(),
              onStepCancel: cancel(),
              controlsBuilder: (BuildContext context,
                  {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                return Row(
                  children: <Widget>[
                    TextButton(
                      onPressed: () => continued(),
                      //need to change onPressed if isReadyToCreate is true
                      child: new Text(
                          (currentStep == 1) ? "Create Model" : "Continue"),
                    ),
                    TextButton(
                      onPressed: () => cancel(),
                      child: new Text('Cancel'),
                    ),
                  ],
                );
              },
              steps: <Step>[
                Step(
                  title: new Text('Connect to 3D Software'),
                  content: Column(
                    children: <Widget>[
                      TextFormField(
                          controller: textController1,
                          decoration: InputDecoration(
                              labelText: 'Target host address')),
                      TextFormField(
                          controller: textController2,
                          decoration:
                              InputDecoration(labelText: 'Target port number')),
                    ],
                  ),
                  isActive: currentStep >= 0,
                  state: currentStep >= 0
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: new Text('Select Sets'),
                  content: new Text('Select Sets'),
                  isActive: currentStep >= 1,
                  state: currentStep >= 1
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: new Text('Create 3D Model'),
                  content: new Text(
                      'This is where it will connect to external software'),
                  isActive: currentStep >= 2,
                  state: currentStep >= 2
                      ? StepState.complete
                      : StepState.disabled,
                ),
              ],
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
    currentStep < 2 ? setState(() => currentStep += 1) : null;
    currentStep <= 1 ? (isReadyToCreate = true) : null;

    //Getting errors here
    /*
    if (currentStep == 1) {
      hostAddress = int.parse(textController1.text);
      portNumber = int.parse(textController2.text);

      dispose();
    }
    */
  }

  cancel() {
    currentStep > 0 ? setState(() => currentStep -= 1) : null;
  }

  void dispose() {
    textController1.dispose();
    textController2.dispose();
    super.dispose();
  }
}
