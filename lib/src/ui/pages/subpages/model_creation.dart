import 'package:flutter/material.dart';

class ModelCreation extends StatefulWidget {
  @override
  ModelCreationState createState() => new ModelCreationState();
}

class MyData {
  String hostAddress;
  String portNumber;
}

class ModelCreationState extends State<ModelCreation> {
  @override
  int currentStep = 0;
  static var _focusNode = new FocusNode();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  static MyData data = new MyData();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  List<Step> steps = [
    new Step(
        title: const Text('Connect to 3D Software'),
        isActive: true,
        state: StepState.indexed,
        content: new TextFormField(
          focusNode: _focusNode,
          keyboardType: TextInputType.text,
          autocorrect: false,
          onSaved: (String hostValue) {
            data.hostAddress = hostValue;
          },
          maxLines: 1,
          validator: (hostValue) {
            if (hostValue.isEmpty || hostValue.length < 1) {
              return 'Please enter a host address';
            }
          },
          decoration: new InputDecoration(
            labelText: 'Host Address',
          ),
        )),
    new Step(
      title: const Text('Connect to 3D Software'),
      isActive: true,
      state: StepState.indexed,
      content: new TextFormField(
        keyboardType: TextInputType.text,
        autocorrect: false,
        onSaved: (String portValue) {
          data.portNumber = portValue;
        },
        validator: (portValue) {
          if (portValue.isEmpty || portValue.length < 1) {
            return 'Please enter a port number';
          }
        },
        maxLines: 1,
        decoration: new InputDecoration(
          labelText: 'Port Number',
        ),
      ),
    ),
    new Step(
      title: const Text('Select Sets'),
      isActive: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    void _submitDetails() {
      final FormState formState = _formKey.currentState;
      formState.save();

      if (!formState.validate()) {
        print('Please enter correct data'); //change to show a pop up
      } else {
        formState.save();
      }
    }

    return new Container(
        child: new Form(
      key: _formKey,
      child: new ListView(children: <Widget>[
        new Stepper(
          steps: steps,
          type: StepperType.horizontal,
          currentStep: this.currentStep,
          onStepContinue: () {
            setState(() {
              if (currentStep < steps.length - 1) {
                currentStep = currentStep + 1;
              } else {
                currentStep = 0;
              }
            });
          },
          onStepCancel: () {
            setState(() {
              if (currentStep > 0) {
                currentStep = currentStep - 1;
              } else {
                currentStep = 0;
              }
            });
          },
          onStepTapped: (step) {
            setState(() {
              currentStep = step;
            });
          },
        ),
        new ElevatedButton(
          child: new Text(
            'Create Model',
            style: new TextStyle(color: Colors.white),
          ),
          onPressed: _submitDetails,
        ),
      ]),
    ));
  }
}

/*
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
                      //need to change onPressed to connect to software if isReadyToCreate is true
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
    if (currentStep == 0) {
      hostAddress = int.parse(textController1.text);
      portNumber = int.parse(textController2.text);

      //dispose();
    }

    currentStep < 2 ? setState(() => currentStep += 1) : null;
    currentStep >= 1 ? (isReadyToCreate = true) : null;

    //Getting errors here
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
  */
