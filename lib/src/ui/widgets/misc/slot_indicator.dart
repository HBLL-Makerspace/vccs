import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:vccs/src/blocs/camera_bloc/camera_bloc.dart';
import 'package:vccs/src/model/domain/configuration.dart';
import 'package:vccs/src/ui/widgets/inherited.dart';

class SlotIndicator extends StatelessWidget {
  final Slot slot;
  final VoidCallback onPressed;

  const SlotIndicator({Key key, this.slot, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Material(
        color: Color(slot.color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Text(slot?.name ?? "Unknown",
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      color: Color(slot.color).computeLuminance() > 0.5
                          ? Colors.black
                          : Colors.white)),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, top: 2, bottom: 2, right: 2),
              child: _cameraStatus(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cameraStatus(BuildContext context) {
    return BlocBuilder<CameraBloc, CameraState>(
        bloc: CameraBloc()..add(LoadCameraDataEvent(slot?.cameraRef?.cameraId)),
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
}
