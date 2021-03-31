import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:photo_view/photo_view.dart';
import 'package:vccs/src/blocs/camera_bloc/camera_bloc.dart';
import 'package:vccs/src/blocs/configuration_bloc/configuration_bloc.dart';
import 'package:vccs/src/blocs/project_bloc/project_bloc.dart';
import 'package:vccs/src/globals.dart';
import 'package:vccs/src/model/backend/path_provider.dart';
import 'package:vccs/src/model/domain/domian.dart';
import 'package:vccs/src/ui/route.gr.dart';
import 'package:vccs/src/ui/widgets/inherited.dart';
import 'package:vccs/src/ui/widgets/widgets.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({Key key}) : super(key: key);

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  double zoom;
  double zoomMin;
  PhotoViewController controller;
  StreamSubscription sub;
  @override
  void initState() {
    super.initState();
    zoom = 1;
    controller = PhotoViewController();
    sub = controller.outputStateStream.listen((event) {
      if (event.scale != 0) {
        setState(() {
          zoom = event.scale;
          zoomMin = event.scale;
        });
        sub.cancel();
      }
    });
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   print
    // });
  }

  @override
  Widget build(BuildContext context) {
    var routeData = RouteData.of(context);
    var setId = routeData.pathParams['set'].value;
    var slotId = routeData.pathParams['slot'].value;
    var slot = configuration.getSlotById(slotId);
    var set = context.read<ProjectBloc>().project.getSetById(setId);
    if (slot != null && set != null) {
      var imagePath = PathProvider.getRawImagePath(
          context.read<ProjectBloc>().project, set, slot);

      return Scaffold(
          body: Material(
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Center(
                child: Container(
              child: PhotoView(
                controller: controller,
                imageProvider: FileImage(File(imagePath)),
              ),
            )),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      ExtendedNavigator.named("project").pop();
                    }),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 24.0, left: 18),
                child: Tooltip(
                  message: 'Open assigned camera',
                  child: SlotIndicator(
                    slot: slot,
                    onPressed: () {
                      ExtendedNavigator.named("project").push(
                          "/cameras/${slot.cameraRef.cameraId}",
                          arguments: SlotPageArguments(slot: slot));
                    },
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: 100,
                    child: Slider(
                        min: zoomMin ?? 1,
                        max: 10,
                        value: zoom,
                        onChanged: (val) {
                          setState(() {
                            zoom = val;
                            controller.scale = zoom;
                          });
                        })),
              ),
            ),
          ],
        ),
      ));
    } else
      return Scaffold(body: Center(child: Text("Can't find photo")));
  }
}
