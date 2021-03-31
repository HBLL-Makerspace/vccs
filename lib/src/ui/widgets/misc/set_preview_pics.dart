import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vccs/src/blocs/camera_bloc/camera_bloc.dart';
import 'package:vccs/src/blocs/configuration_bloc/configuration_bloc.dart';
import 'package:vccs/src/blocs/project_bloc/project_bloc.dart';
import 'package:vccs/src/blocs/slot_preview_image/slot_preview_image_bloc.dart';
import 'package:vccs/src/globals.dart';
import 'package:vccs/src/model/domain/domian.dart';
import 'package:vccs/src/ui/route.gr.dart';
import 'package:vccs/src/ui/widgets/buttons.dart';
import 'package:vccs/src/ui/widgets/cards.dart';
import 'package:vccs/src/ui/widgets/inherited.dart';
import 'package:vccs/src/ui/widgets/misc/slot_indicator.dart';

class SetPreviewPictures extends StatelessWidget {
  final VCCSSet set;
  final double size;
  final double offset;

  const SetPreviewPictures({
    Key key,
    this.set,
    this.size = 120,
    this.offset = 0,
  }) : super(key: key);

  Widget _picture(BuildContext context, int i) {
    Project project = context.read<ProjectBloc>().project;
    Slot slot = configuration.getSlots().elementAt(i);
    return BlocBuilder<SlotPreviewImageBloc, SlotPreviewImageState>(
      bloc:
          SlotPreviewImageBloc(context.read<ProjectBloc>().project, set, slot),
      builder: (context, state) {
        bool isLoading = state is LoadingSlotPreviewImageState;
        File file =
            ((state is LoadedSlotPreviewImageState) && state.file != null)
                ? state.file
                : null;
        return Container(
          width: size,
          height: size,
          child: AdvancedCard(
            child: isLoading
                ? SpinKitCircle(
                    size: 24,
                    color: Colors.grey[400],
                  )
                : file == null
                    ? Icon(Icons.picture_in_picture)
                    : Image.file(
                        file,
                        fit: BoxFit.cover,
                      ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final int maxPics = ((_size.width - offset) / size).floor();
    return BlocBuilder<ConfigurationBloc, ConfigurationState>(
      builder: (context, state) {
        if (state is ConfigurationDataState) {
          final int numPics = maxPics > state.configuration.slots.length
              ? state.configuration.slots.length
              : maxPics;
          return Row(
            children: [for (int i = 0; i < numPics; i++) _picture(context, i)],
          );
        } else
          return Container();
      },
    );
  }
}

class SlotImagePreview extends StatelessWidget {
  final VCCSSet set;
  final Slot slot;

  const SlotImagePreview({
    Key key,
    this.set,
    this.slot,
  }) : super(key: key);

  Widget _picture(BuildContext context) {
    Project project = context.read<ProjectBloc>().project;
    return BlocBuilder<SlotPreviewImageBloc, SlotPreviewImageState>(
      bloc:
          SlotPreviewImageBloc(context.read<ProjectBloc>().project, set, slot),
      builder: (context, state) {
        bool isLoading = state is LoadingSlotPreviewImageState;
        File file =
            ((state is LoadedSlotPreviewImageState) && state.file != null)
                ? state.file
                : null;
        return _SlotImagePreview(
            set: set,
            slot: slot,
            image: isLoading
                ? SpinKitCircle(
                    size: 24,
                    color: Colors.grey[400],
                  )
                : file == null
                    ? Center(child: Icon(Icons.picture_in_picture))
                    : Image.file(
                        file,
                        fit: BoxFit.cover,
                      ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _picture(context);
  }
}

class _SlotImagePreview extends StatefulWidget {
  final Widget image;
  final Slot slot;
  final VCCSSet set;

  const _SlotImagePreview({
    Key key,
    this.image,
    this.slot,
    this.set,
  }) : super(key: key);

  @override
  __SlotImagePreviewState createState() => __SlotImagePreviewState();
}

class __SlotImagePreviewState extends State<_SlotImagePreview> {
  Widget _picture(BuildContext context) {
    return Material(
      elevation: 8.0,
      child: InkWell(
        onTap: () {
          ExtendedNavigator.named("project")
              .push("/slotimage/${widget.set.uid}/${widget.slot.id}");
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: widget.image,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Tooltip(
                    message: 'Open assigned camera',
                    child: SlotIndicator(
                      slot: widget.slot,
                      onPressed: () {
                        ExtendedNavigator.named("project").push(
                            "/cameras/${widget.slot.cameraRef.cameraId}",
                            arguments: SlotPageArguments(slot: widget.slot));
                      },
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ButtonTheme(
                height: 18,
                minWidth: 10,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: VCCSFlatButton(
                    child: Text(
                      "Retake",
                      style: TextStyle(fontSize: 12),
                    ),
                    onPressed: () {},
                    padding: EdgeInsets.all(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _picture(context);
  }
}
