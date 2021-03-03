import 'package:flutter/material.dart';
import 'package:vccs/src/model/domain/domian.dart';
import 'package:vccs/src/ui/widgets/buttons.dart';
import 'package:vccs/src/ui/widgets/cards.dart';

class SetPage extends StatelessWidget {
  final VCCSSet set;

  SetPage({Key key, this.set}) : super(key: key);

  final List<Slot> _slots = [
    Slot(
        id: "1",
        camera: Camera(id: "D3435", model: "D300"),
        status: Status.CONNECTED),
    Slot(
        id: "2",
        camera: Camera(id: "D3436", model: "D300"),
        status: Status.CONNECTED),
    Slot(
        id: "3",
        camera: Camera(id: "D3437", model: "D300"),
        status: Status.CONNECTED),
    Slot(
        id: "4",
        camera: Camera(id: "D3438", model: "D300"),
        status: Status.CONNECTING),
    Slot(
        id: "5",
        camera: Camera(id: "D3439", model: "D300"),
        status: Status.CONNECTING),
    Slot(
        id: "6",
        camera: Camera(id: "D3440", model: "D300"),
        status: Status.CONNECTING),
    Slot(
        id: "7",
        camera: Camera(id: "D3441", model: "D300"),
        status: Status.CONNECTING),
    Slot(
        id: "8",
        camera: Camera(id: "D3442", model: "D300"),
        status: Status.NOT_CONNECTED),
    Slot(
        id: "9",
        camera: Camera(id: "D3443", model: "D300"),
        status: Status.NOT_CONNECTED),
    Slot(
        id: "10",
        camera: Camera(id: "D3444", model: "D300"),
        status: Status.NOT_CONNECTED),
  ];

  Widget _picture() {
    return SlotCard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(set?.name ?? "Unknown"),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Wrap(
          children: [
            ..._slots
                .map((e) => SlotCard(
                      slot: e,
                      onPressed: () {},
                    ))
                .toList()
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            VCCSRaisedButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Take Pictures"),
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
