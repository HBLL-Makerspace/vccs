import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vccs/src/blocs/configuration_bloc/configuration_bloc.dart';
import 'package:vccs/src/blocs/project_bloc/project_bloc.dart';
import 'package:vccs/src/blocs/slot_preview_image/slot_preview_image_bloc.dart';
import 'package:vccs/src/model/domain/domian.dart';
import 'package:vccs/src/ui/widgets/cards.dart';

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
    Slot slot =
        context.read<ConfigurationBloc>().configuration.getSlots().elementAt(i);
    return BlocBuilder<SlotPreviewImageBloc, SlotPreviewImageState>(
      cubit: SlotPreviewImageBloc()
        ..add(LoadSlotPreviewImageEvent(project, set, slot)),
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
