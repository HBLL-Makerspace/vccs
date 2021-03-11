import 'package:flutter/material.dart';
import 'package:vccs/src/model/domain/domian.dart';
import 'package:vccs/src/ui/widgets/buttons.dart';
import 'package:vccs/src/ui/widgets/cards.dart';

class SetPage extends StatelessWidget {
  final VCCSSet set;

  SetPage({Key key, this.set}) : super(key: key);

  final List<Slot> _slots = [];

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
