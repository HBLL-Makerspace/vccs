import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vccs/src/model/backend/implementations/camera_properties.dart';
import 'package:vccs/src/ui/widgets/widgets.dart';

class CameraPropertyWidget extends StatelessWidget {
  final CameraProperty cameraProperty;

  const CameraPropertyWidget({Key key, this.cameraProperty}) : super(key: key);

  Widget _inputFromType(BuildContext context) {
    Widget input = Container(
      child: Text("Unimplmeneted type: ${cameraProperty.runtimeType}"),
    );
    switch (cameraProperty.runtimeType) {
      case CameraTextProperty:
        input = CameraTextPropertyWidget(
          property: cameraProperty,
        );
        break;
      case CameraRangeProperty:
        input = CameraRangePropertyWidget(
          property: cameraProperty,
        );
        break;
      case CameraToggleProperty:
        input = CameraTogglePropertyWidget(
          property: cameraProperty,
        );
        break;
    }
    return input;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          // flex: 1,
          child: Text(
            "${cameraProperty.label} (${cameraProperty.name})",
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        Expanded(
          flex: 2,
          child: _inputFromType(context),
        )
      ],
    );
  }
}

class CameraTextPropertyWidget extends StatefulWidget {
  final CameraTextProperty property;

  const CameraTextPropertyWidget({Key key, this.property}) : super(key: key);

  @override
  _CameraTextPropertyWidgetState createState() =>
      _CameraTextPropertyWidgetState();
}

class _CameraTextPropertyWidgetState extends State<CameraTextPropertyWidget> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.property.value.toString());
  }

  @override
  Widget build(BuildContext context) {
    return VCCSTextFormField(
        enabled: !widget.property.readOnly, controller: _controller);
  }
}

class CameraRangePropertyWidget extends StatefulWidget {
  final CameraRangeProperty property;

  const CameraRangePropertyWidget({Key key, this.property}) : super(key: key);

  @override
  _CameraRangePropertyWidgetState createState() =>
      _CameraRangePropertyWidgetState();
}

class _CameraRangePropertyWidgetState extends State<CameraRangePropertyWidget> {
  double value;

  @override
  void initState() {
    super.initState();
    value = widget.property.value;
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
        valueIndicatorColor: Theme.of(context).primaryColor,
        valueIndicatorTextStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      child: Slider(
        value: value,
        label: value.toString(),
        divisions: ((widget.property.low.abs() + widget.property.high.abs()) /
                widget.property.increment)
            .round(),
        min: widget.property.low,
        max: widget.property.high,
        onChanged: (double val) => setState(() => value = val),
      ),
    );
  }
}

class CameraTogglePropertyWidget extends StatefulWidget {
  final CameraToggleProperty property;

  const CameraTogglePropertyWidget({Key key, this.property}) : super(key: key);

  @override
  _CameraTogglePropertyWidgetState createState() =>
      _CameraTogglePropertyWidgetState();
}

class _CameraTogglePropertyWidgetState extends State<CameraTogglePropertyWidget>
    with SingleTickerProviderStateMixin {
  bool isSelected;

  AnimationController _controller;
  Animation<double> _size;

  @override
  void initState() {
    super.initState();
    isSelected = widget.property.value;
    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    final Animation curve =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _size = Tween<double>(begin: 32, end: 0).animate(curve)
      ..addListener(() => setState(() {}));
    if (isSelected)
      _controller.forward();
    else
      _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      renderBorder: true,
      borderRadius: BorderRadius.circular(16.0),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _size.value),
          child: Row(
            children: [Text("On")],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32 - _size.value),
          child: Row(
            children: [Text("Off")],
          ),
        ),
      ],
      onPressed: (int index) {
        setState(() {
          isSelected = !isSelected;
          if (isSelected)
            _controller.forward();
          else
            _controller.reverse();
        });
      },
      isSelected: [isSelected, !isSelected],
    );
  }
}
