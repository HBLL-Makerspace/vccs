import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:vccs/src/model/domain/domian.dart';

class SlotCard extends StatefulWidget {
  final Slot slot;
  final bool showCheckbox;
  final bool isChecked;
  final ValueChanged<bool> onCheckboxClicked;
  final VoidCallback onPressed;

  const SlotCard(
      {Key key,
      this.slot,
      this.showCheckbox = false,
      this.onCheckboxClicked,
      this.isChecked,
      this.onPressed})
      : super(key: key);

  @override
  _SlotCardState createState() => _SlotCardState();
}

class _SlotCardState extends State<SlotCard> {
  Widget _status(BuildContext context, Status status) {
    switch (status) {
      case Status.CONNECTED:
        return Tooltip(
          message: 'Camera is connected',
          child: Icon(
            MaterialCommunityIcons.camera,
            size: 18,
            color: Colors.green[400],
          ),
        );
      case Status.CONNECTING:
        return Tooltip(
          message: 'Connecting to camera',
          child: Icon(
            Icons.linked_camera,
            size: 18,
            color: Colors.amber[300],
          ),
        );
      case Status.NOT_CONNECTED:
        return Tooltip(
          message: 'Something went wrong, camera is not connected',
          child: Icon(
            Feather.alert_triangle,
            size: 18,
            color: Colors.red[400],
          ),
        );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: AdvancedCard(
        onPressed: widget.onPressed,
        child: Stack(
          children: [
            if (widget.showCheckbox)
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Checkbox(
                      activeColor: Theme.of(context).accentColor,
                      value: widget.isChecked,
                      onChanged: widget.onCheckboxClicked ?? (_) {}),
                ),
              ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _status(context, widget.slot.status),
              ),
            ),
            Center(
              child: Column(
                children: [
                  Expanded(
                    child: Icon(
                      Ionicons.md_camera,
                      size: 32,
                      color: Colors.grey[400],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(widget.slot.id),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdvancedCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;

  const AdvancedCard({Key key, this.onPressed, this.child}) : super(key: key);

  @override
  _AdvancedCardState createState() => _AdvancedCardState();
}

class _AdvancedCardState extends State<AdvancedCard> {
  bool _isHover;

  @override
  void initState() {
    super.initState();
    _isHover = false;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) => setState(() => _isHover = true),
      onExit: (e) => setState(() => _isHover = false),
      child: Card(
        elevation: _isHover ? 16.0 : 4.0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          child: Material(
              color: Colors.transparent,
              child: InkWell(
                child: widget.child,
                onTap: widget.onPressed ?? () {},
              )),
        ),
      ),
    );
  }
}

class SetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AdvancedCard(
            onPressed: () => ExtendedNavigator.named("project").push("/sets/0"),
            child: Container(
              height: 200,
              child: Text("hello"),
            ),
          ),
        ),
      ],
    );
  }
}
