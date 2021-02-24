import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:vccs/src/model/domain/domian.dart';
import 'package:vccs/src/ui/widgets/widgets.dart';

class CameraSets extends StatefulWidget {
  @override
  _CameraSetsState createState() => _CameraSetsState();
}

class _CameraSetsState extends State<CameraSets> {
  List<VCCSSet> sets;

  @override
  void initState() {
    super.initState();
    sets = [];
  }

  Widget _addSetButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Tooltip(
          message: 'Create a new set',
          child: FloatingActionButton(
            onPressed: () async {
              String name = await showDialog<String>(
                  context: context, builder: (context) => CreateSet());
              if (name != null)
                setState(() {
                  sets.add(VCCSSet(name: name));
                });
            },
            child: Icon(Icons.add_a_photo),
          ),
        ),
      ),
    );
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

  List<Widget> _sets() {
    return sets
        .map((e) => Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              child: SetCard(),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  "Sets",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  children: [
                    if (sets.isEmpty) _addSetBox(),
                    if (sets.isNotEmpty) ..._sets(),
                  ],
                ),
              ),
            ],
          ),
        ),
        _addSetButton()
      ],
    );
  }
}
