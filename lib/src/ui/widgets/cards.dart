import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:vccs/src/model/backend/interfaces/camera_interface.dart';
import 'package:vccs/src/model/domain/camera_config.dart';
import 'package:vccs/src/model/domain/domian.dart';
import 'package:vccs/src/ui/widgets/buttons.dart';
import 'package:vccs/src/ui/widgets/floating_modal.dart';
import 'package:vccs/src/ui/widgets/misc/set_preview_pics.dart';
import 'package:vccs/src/ui/widgets/widgets.dart';

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
  final bool showHighlight;

  const AdvancedCard(
      {Key key, this.onPressed, this.child, this.showHighlight = false})
      : super(key: key);

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
                hoverColor: widget.showHighlight ? null : Colors.transparent,
                child: widget.child,
                onTap: widget.onPressed ?? () {},
                focusColor: Colors.transparent,
              )),
        ),
      ),
    );
  }
}

class SetCard extends StatelessWidget {
  final VCCSSet set;
  final VoidCallback onSetAsMask;
  final VoidCallback onDelete;

  const SetCard({Key key, @required this.set, this.onSetAsMask, this.onDelete})
      : super(key: key);

  Widget _maskButtons() {
    return Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: !set.isMask
              ? VCCSFlatButton(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text("Use as mask"),
                  ),
                  onPressed: onSetAsMask ?? () {},
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.green[400],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(Entypo.mask),
                  ),
                ),
        ));
  }

  Widget _title(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          set.name,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }

  Widget _deleteButton() {
    return VCCSFlatButton(
        onPressed: onDelete ?? () {},
        child: Text("Delete"),
        hoverColor: Colors.red[400]);
  }

  Widget _pictures() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
                child: SetPreviewPictures(
              set: set,
              offset: 274,
            )),
            _deleteButton()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AdvancedCard(
            onPressed: () => ExtendedNavigator.named("project").push("/sets/0"),
            child: Container(
              height: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [_title(context), _maskButtons(), _pictures()],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CameraCard extends StatelessWidget {
  final ICamera camera;
  final VoidCallback onPressed;

  const CameraCard({Key key, this.camera, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: AdvancedCard(
        onPressed: onPressed ?? () {},
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        camera.getModel(),
                        overflow: TextOverflow.fade,
                        softWrap: false,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image(
                image: AssetImage(CameraConfiguration.getMediumThumbnailFor(
                    camera.getModel())),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  camera.getId(),
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SlotConfigCard extends StatelessWidget {
  final Slot slot;
  final VoidCallback onPressed;

  SlotConfigCard({Key key, this.slot, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: AdvancedCard(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        slot.id + ": " + (slot.name ?? ""),
                        overflow: TextOverflow.fade,
                        softWrap: false,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: slot.camera != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        image: AssetImage(
                            CameraConfiguration.getMediumThumbnailFor(
                                slot.camera.model)),
                      ),
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Icon(
                          Ionicons.md_camera,
                          size: 32,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: slot.camera == null
                    ? VCCSFlatButton(
                        child: Text("Assign"),
                        onPressed: () {
                          showFloatingModalBottomSheet(
                              context: context, builder: (_) => SelectCamera());
                        },
                      )
                    : Text(
                        slot.camera.id,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
