import 'package:flutter/material.dart';
import 'package:vccs/src/ui/widgets/textfield.dart';
import 'package:vccs/src/ui/widgets/buttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vccs/src/blocs/project_bloc/project_bloc.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:vccs/src/model/domain/set.dart';
import 'package:vccs/src/ui/widgets/cards.dart';

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
    return BlocBuilder<ProjectBloc, ProjectState>(
        bloc: ProjectBloc(),
        builder: (context, state) {
          if (state is ProjectDataState) {
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
                                alignment: Alignment.topCenter,
                                margin: EdgeInsets.all(10.0),
                                child: VCCSTextFormField(
                                  label: "Enter the target host address",
                                  controller: hostController,
                                ),
                              ),
                              Container(
                                  alignment: Alignment.topCenter,
                                  margin: EdgeInsets.all(10.0),
                                  child: VCCSTextFormField(
                                    label: "Enter the target port number",
                                    controller: portController,
                                  )),
                              Column(
                                //trying to make the buttons go to the bottom of the page
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Tooltip(
                                              message: "Continue",
                                              child: FloatingActionButton(
                                                onPressed: () {
                                                  data.hostAddress =
                                                      hostController.text;
                                                  data.portNumber =
                                                      portController.text;
                                                  continued();
                                                },
                                                child: Icon(Icons
                                                    .arrow_forward_ios_outlined),
                                              ))))
                                ],
                              )
                            ],
                          ),
                          isActive: currentStep >= 0,
                          state: currentStep > 0
                              ? StepState.complete
                              : StepState.disabled,
                        ),
                        Step(
                          title: new Text('Select Sets'),
                          content: Column(
                            //trying to make the buttons go to the bottom of the page
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: ListView(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16.0),
                                      child: Text(
                                        "Sets",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16.0),
                                      child: Column(
                                        children: [
                                          if (state.project.sets.isEmpty)
                                            _addSetBox(),
                                          if (state.project.sets.isNotEmpty)
                                            ..._sets(state.project.sets)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              new Text("Temporary content"),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Tooltip(
                                              message: "Back",
                                              child: FloatingActionButton(
                                                onPressed: () {
                                                  cancel();
                                                },
                                                child: Icon(Icons
                                                    .arrow_back_ios_outlined),
                                              )))),
                                  Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Tooltip(
                                              message: "Continue",
                                              child: FloatingActionButton(
                                                onPressed: () {
                                                  continued();
                                                },
                                                child: Icon(Icons
                                                    .arrow_forward_ios_outlined),
                                              ))))
                                ],
                              )
                            ],
                          ),
                          isActive: currentStep >= 1,
                          state: currentStep > 1
                              ? StepState.complete
                              : StepState.disabled,
                        ),
                        Step(
                          title: new Text('Create 3D Model'),
                          //Starts creating software, when done we can push the button to continue
                          content: Column(
                            children: [
                              new Text(
                                  'This is where it will connect to external software'),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Tooltip(
                                              message: "Cancel",
                                              child: FloatingActionButton(
                                                onPressed: () {
                                                  cancel();
                                                },
                                                child: Icon(Icons
                                                    .arrow_back_ios_outlined),
                                              )))),
                                  Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Tooltip(
                                              message: "Create Model",
                                              child: FloatingActionButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PostCreation()));
                                                },
                                                child: Icon(Icons
                                                    .arrow_forward_ios_outlined),
                                              ))))
                                ],
                              )
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
          } else
            return Scaffold(
              body: Center(child: Text("loading sets")),
            );
        });
    /*
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
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.all(10.0),
                        child: VCCSTextFormField(
                          label: "Enter the target host address",
                          controller: hostController,
                        ),
                      ),
                      Container(
                          alignment: Alignment.topCenter,
                          margin: EdgeInsets.all(10.0),
                          child: VCCSTextFormField(
                            label: "Enter the target port number",
                            controller: portController,
                          )),
                      Column(
                        //trying to make the buttons go to the bottom of the page
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Tooltip(
                                      message: "Continue",
                                      child: FloatingActionButton(
                                        onPressed: () {
                                          data.hostAddress =
                                              hostController.text;
                                          data.portNumber = portController.text;
                                          continued();
                                        },
                                        child: Icon(
                                            Icons.arrow_forward_ios_outlined),
                                      ))))
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
                    //trying to make the buttons go to the bottom of the page
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      new Text("Temporary content"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Tooltip(
     r                                 message: "Back",
                                      child: FloatingActionButton(
                                        onPressed: () {
                                          cancel();
                                        },
                                        child:
                                            Icon(Icons.arrow_back_ios_outlined),
                                      )))),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Tooltip(
                                      message: "Continue",
                                      child: FloatingActionButton(
                                        onPressed: () {
                                          continued();
                                        },
                                        child: Icon(
                                            Icons.arrow_forward_ios_outlined),
                                      ))))
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Tooltip(
                                      message: "Cancel",
                                      child: FloatingActionButton(
                                        onPressed: () {
                                          cancel();
                                        },
                                        child:
                                            Icon(Icons.arrow_back_ios_outlined),
                                      )))),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Tooltip(
                                      message: "Create Model",
                                      child: FloatingActionButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PostCreation()));
                                        },
                                        child: Icon(
                                            Icons.arrow_forward_ios_outlined),
                                      ))))
                        ],
                      )
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
    */
    hostController.dispose();
    portController.dispose();
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

  List<Widget> _sets(List<VCCSSet> sets) {
    return sets
        .map((e) => Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              child: SetCard(
                set: e,
                onSetAsMask: () =>
                    context.read<ProjectBloc>().add(SetMaskEvent(e)),
                onDelete: () => setState(
                    () => context.read<ProjectBloc>().add(RemoveSetEvent(e))),
              ),
            ))
        .toList();
  }

  Widget _addSetBox() {
    return Row(
      children: [
        Expanded(
          child: DottedBorder(
            dashPattern: [6, 3],
            strokeCap: StrokeCap.round,
            borderType: BorderType.RRect,
            radius: Radius.circular(16),
            color: Colors.grey[400],
            child: Container(
              height: 200,
              child: Center(
                child: Text(
                  "There are no sets. To add a set click on the blue button.",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.grey[400]),
                ),
              ),
            ),
          ),
        ),
      ],
    );
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
        child: Text(
            "This can either be a loading screen that pushes to an assembled model screen or just an assembled model screen."),
      ),
    );
  }
}
