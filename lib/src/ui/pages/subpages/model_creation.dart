import 'package:flutter/material.dart';

class ModelCreation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ModelCreationState();
  }
}

class ModelCreationState extends State<ModelCreation> {
  @override
  int currentStep = 0;
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
                      onPressed: onStepContinue,
                      child: Text((currentStep >= 2) ? 'CREATE MODEL' : 'NEXT'),
                    ),
                    TextButton(
                      onPressed: onStepCancel,
                      child: const Text('CANCEL'),
                    ),
                  ],
                );
              },
              steps: <Step>[
                Step(
                  title: new Text('Sets'),
                  content: new Text('Step One'),
                  isActive: currentStep >= 0,
                  state: currentStep >= 0
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: new Text('S'),
                  content: new Text('Step Two'),
                  isActive: currentStep >= 0,
                  state: currentStep >= 1
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: new Text('Create 3D Model'),
                  content: new Text('Create Model'),
                  isActive: currentStep >= 0,
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
  }

  cancel() {
    currentStep > 0 ? setState(() => currentStep -= 1) : null;
  }
}
