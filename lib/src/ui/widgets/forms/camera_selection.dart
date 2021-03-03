import 'package:flutter/material.dart';
import 'package:vccs/src/model/backend/backend.dart';
import 'package:vccs/src/model/domain/camera_config.dart';
import 'package:vccs/src/ui/widgets/textfield.dart';

class SelectCamera extends StatelessWidget {
  final bool filter;

  const SelectCamera({Key key, this.filter = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 500,
        maxHeight: 400,
      ),
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: VCCSTextFormField(
                label: "Search",
              ),
            ),
            Expanded(
              child: Scrollbar(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ...DummyData.cameras
                        .map((e) => ListTile(
                              title: Text(e.model ?? "Unknown"),
                              subtitle: Text(e.id ?? "Unknown"),
                              leading: Image(
                                image: AssetImage(
                                    CameraConfiguration.getSmallThumbnailFor(
                                        e.model)),
                              ),
                              onTap: () {
                                Navigator.pop(context, e);
                              },
                            ))
                        .toList()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
