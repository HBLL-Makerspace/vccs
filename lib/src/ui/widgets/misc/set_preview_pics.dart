import 'package:flutter/material.dart';
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

  Widget _picture(int i) {
    return Container(
      width: size,
      height: size,
      child: AdvancedCard(
        child: Icon(Icons.picture_in_picture),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final int numPics = ((_size.width - offset) / size).floor();
    return Row(
      children: [for (int i = 0; i < numPics; i++) _picture(i)],
    );
  }
}
