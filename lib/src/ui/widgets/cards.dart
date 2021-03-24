import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:vccs/src/blocs/camera_bloc/camera_bloc.dart';
import 'package:vccs/src/blocs/configuration_bloc/configuration_bloc.dart';
import 'package:vccs/src/model/backend/interfaces/camera_interface.dart';
import 'package:vccs/src/model/domain/camera_config.dart';
import 'package:vccs/src/model/domain/domian.dart';
import 'package:vccs/src/ui/widgets/buttons.dart';
import 'package:vccs/src/ui/widgets/floating_modal.dart';
import 'package:vccs/src/ui/widgets/misc/set_preview_pics.dart';
import 'package:vccs/src/ui/widgets/widgets.dart';
import 'package:vccs/src/ui/route.gr.dart';

class AdvancedCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final bool showHighlight;
  final Color color;

  const AdvancedCard(
      {Key key,
      this.onPressed,
      this.child,
      this.showHighlight = false,
      this.color})
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
    Widget card = Container(
      child: Material(
          color: Colors.transparent,
          child: InkWell(
            hoverColor: widget.showHighlight ? null : Colors.transparent,
            child: widget.child,
            onTap: widget.onPressed ?? () {},
            focusColor: Colors.transparent,
          )),
    );
    return MouseRegion(
      onEnter: (e) => setState(() => _isHover = true),
      onExit: (e) => setState(() => _isHover = false),
      child: Card(
        elevation: _isHover ? 16.0 : 4.0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: widget.color,
        child: card,
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
            onPressed: () => ExtendedNavigator.named("project").push(
                "/sets/${set.uid}",
                arguments: SetPageArguments(set: set)),
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
  final CameraRef cameraRef;

  const CameraCard({Key key, this.camera, this.onPressed, this.cameraRef})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String cameraModel;
    String cameraId;

    if (cameraRef != null) {
      cameraModel = cameraRef.cameraModel;
      cameraId = cameraRef.cameraId;
    } else if (camera != null) {
      cameraModel = camera.getModel();
      cameraId = camera.getId();
    }

    return SizedBox(
      width: 150,
      height: 150,
      child: AdvancedCard(
        onPressed: onPressed ?? () {},
        child: camera == null && cameraRef == null
            ? Center(
                child: Text("No Camera"),
              )
            : Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              cameraModel,
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
                      image: AssetImage(
                          CameraConfiguration.getMediumThumbnailFor(
                              cameraModel)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        cameraId,
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

class SlotCard extends StatefulWidget {
  final Slot slot;
  final VoidCallback onPressed;
  final bool showCheckbox;
  final bool showRemove;
  final VoidCallback onRemove;
  final bool isChecked;
  final ValueChanged<bool> onCheckboxClicked;

  SlotCard(
      {Key key,
      this.slot,
      this.onPressed,
      this.showCheckbox = false,
      this.isChecked,
      this.onCheckboxClicked,
      this.showRemove = false,
      this.onRemove})
      : super(key: key);

  @override
  _SlotCardState createState() => _SlotCardState();
}

class _SlotCardState extends State<SlotCard> {
  Widget _cameraStatus(BuildContext context) {
    return BlocBuilder<CameraBloc, CameraState>(
        bloc: CameraBloc(AppData.of(context).controller)
          ..add(LoadCameraDataEvent(widget.slot?.cameraRef?.cameraId)),
        builder: (context, state) {
          bool error = true;
          if (state is CameraDataState) error = state.camera == null;
          Widget icon;
          if (!error)
            icon = Tooltip(
                message: 'Connected',
                child: Icon(Icons.done, color: Colors.green, size: 16));
          else
            icon = Tooltip(
              message: "Camera is not connected",
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child:
                    Icon(Feather.alert_triangle, color: Colors.red, size: 12),
              ),
            );
          return Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: icon,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: AdvancedCard(
        onPressed: widget.onPressed,
        color: Color(widget.slot.color),
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
                        widget.slot.name ?? widget.slot.id,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: TextStyle(
                            color: Color(widget.slot.color).computeLuminance() >
                                    0.5
                                ? Colors.black
                                : Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.slot?.cameraRef?.cameraId != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        image: AssetImage(
                            CameraConfiguration.getMediumThumbnailFor(
                                widget.slot?.cameraRef?.cameraModel)),
                      ),
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Icon(
                          Ionicons.md_camera,
                          size: 32,
                          color:
                              Color(widget.slot.color).computeLuminance() > 0.5
                                  ? Colors.black
                                  : Colors.grey[400],
                        ),
                      ),
                    ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: widget.slot?.cameraRef?.cameraId == null
                    ? VCCSFlatButton(
                        child: Text(
                          "Assign",
                          style: TextStyle(
                              color:
                                  Color(widget.slot.color).computeLuminance() >
                                          0.5
                                      ? Colors.black
                                      : Colors.white),
                        ),
                        onPressed: () async {
                          var cam = await showFloatingModalBottomSheet<ICamera>(
                              context: context, builder: (_) => SelectCamera());
                          if (cam != null)
                            context.read<ConfigurationBloc>().add(
                                ConfigurationAssignCameraToSlotEvent(
                                    widget.slot, cam));
                        },
                      )
                    : Text(
                        widget.slot?.cameraRef?.cameraId,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            color: Color(widget.slot.color).computeLuminance() >
                                    0.5
                                ? Colors.black
                                : Colors.white),
                      ),
              ),
            ),
            if (widget.showCheckbox && !widget.showRemove)
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Checkbox(
                      activeColor: Theme.of(context).accentColor,
                      value: widget.isChecked,
                      onChanged: widget.onCheckboxClicked ?? (_) {}),
                ),
              ),
            if (widget.showRemove)
              Align(
                alignment: Alignment.topRight,
                child: Tooltip(
                  message: "Remove slot",
                  child: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Color(widget.slot.color).computeLuminance() > 0.5
                          ? Colors.black
                          : Colors.white,
                    ),
                    onPressed: widget.onRemove,
                  ),
                ),
              ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: _cameraStatus(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
