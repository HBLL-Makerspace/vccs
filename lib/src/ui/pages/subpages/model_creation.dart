import 'package:flutter/material.dart';
import 'package:vccs/src/ui/widgets/textfield.dart';
import 'package:vccs/src/ui/pages/subpages/set.dart';

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
  bool modelComplete = false;
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
              onStepContinue: continued(),
              onStepCancel: cancel(),
              controlsBuilder: (BuildContext context,
                  {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                return Row(
                  children: <Widget>[
                    TextButton(
                      onPressed: () => continued(),
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
              steps: pageSteps(),
              currentStep: this.currentStep,
            )),
          ],
        ),
      ),
    );
  }

  List<Step> pageSteps() {
    List<Step> steps = [
      Step(
        title: new Text('Connect to 3D Software'),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: VCCSTextFormField(
                label: "Enter the target host address",
                //onSubmitted:
              ),
            ),
            Container(
                child: VCCSTextFormField(
              label: "Enter the target port number",
              //onSubmitted
            )),
          ],
        ),
        isActive: currentStep >= 0,
        state: currentStep > 0 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: new Text('Select Sets'),
        //content: SetPage().build(context),
        content: new Text("Temporary content"),
        isActive: currentStep >= 1,
        state: currentStep > 1 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: new Text('Create 3D Model'),
        //Starts creating software, when done we can push the button to continue

        content: new Text('This is where it will connect to external software'),
        isActive: currentStep >= 2,
        state: currentStep >= 2 ? StepState.complete : StepState.disabled,
      ),
    ];

    return steps;
  }

  tapped(int step) {
    setState(() => currentStep = step);
  }

  continued() {
    setState(() {
      if (this.currentStep < this.pageSteps().length) {
        this.currentStep = this.currentStep + 1;
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PostCreation()));
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
