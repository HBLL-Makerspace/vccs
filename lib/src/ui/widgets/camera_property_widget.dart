import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vccs/src/model/backend/implementations/camera_properties.dart';
import 'package:vccs/src/model/backend/interfaces/camera_interface.dart';
import 'package:vccs/src/ui/widgets/widgets.dart';

class CameraPropertyWidget extends StatelessWidget {
  final CameraProperty cameraProperty;
  final ICamera camera;
  final ValueChanged<CameraProperty> onUpdate;
  final bool enabled;

  const CameraPropertyWidget(
      {Key key,
      this.cameraProperty,
      this.camera,
      this.onUpdate,
      this.enabled = true})
      : super(key: key);

  Widget _inputFromType(BuildContext context, ValueChanged<dynamic> onUpdate) {
    Widget input = Container(
      child: Text("Unimplmeneted type: ${cameraProperty.runtimeType}"),
    );
    switch (cameraProperty.runtimeType) {
      case CameraTextProperty:
        input = CameraTextPropertyWidget(
          property: cameraProperty,
          onUpdate: onUpdate,
          enabled: enabled,
        );
        break;
      case CameraRangeProperty:
        input = CameraRangePropertyWidget(
          property: cameraProperty,
          onUpdate: onUpdate,
          enabled: enabled,
        );
        break;
      case CameraToggleProperty:
        input = CameraTogglePropertyWidget(
          property: cameraProperty,
          onUpdate: onUpdate,
          enabled: enabled,
        );
        break;
      case CameraDateProperty:
        input = CameraDateTimePropertyWidget(
          property: cameraProperty,
          onUpdate: onUpdate,
          enabled: enabled,
        );
        break;
      case CameraRadioProperty:
        input = CameraRadioPropertyWidget(
          property: cameraProperty,
          onUpdate: onUpdate,
          enabled: enabled,
        );
        break;
      case CameraDropDownProperty:
        input = CameraDropDownPropertyWidget(
          property: cameraProperty,
          onUpdate: onUpdate,
          enabled: enabled,
        );
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
          child: _inputFromType(
            context,
            (v) {
              if (onUpdate != null) {}
              onUpdate(cameraProperty.copyWith(value: v));
            },
          ),
        )
      ],
    );
  }
}

class CameraTextPropertyWidget extends StatefulWidget {
  final CameraTextProperty property;
  final ValueChanged<dynamic> onUpdate;
  final bool enabled;

  const CameraTextPropertyWidget(
      {Key key, this.property, this.onUpdate, this.enabled = false})
      : super(key: key);

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
      enabled: !widget.property.readOnly && widget.enabled,
      controller: _controller,
      onSubmitted: (val) {
        if (widget.onUpdate != null) {
          widget.onUpdate(val);
        }
      },
    );
  }
}

class CameraRangePropertyWidget extends StatefulWidget {
  final CameraRangeProperty property;
  final ValueChanged<dynamic> onUpdate;
  final bool enabled;

  const CameraRangePropertyWidget(
      {Key key, this.property, this.onUpdate, this.enabled = false})
      : super(key: key);

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
        onChanged: !widget.property.readOnly && widget.enabled
            ? (double val) => setState(() => value = val)
            : null,
        onChangeEnd: !widget.property.readOnly && widget.enabled
            ? (double endVal) {
                setState(() => value = endVal);
                if (widget.onUpdate != null) widget.onUpdate(endVal);
              }
            : null,
      ),
    );
  }
}

class CameraTogglePropertyWidget extends StatefulWidget {
  final CameraToggleProperty property;
  final ValueChanged<dynamic> onUpdate;
  final bool enabled;

  const CameraTogglePropertyWidget(
      {Key key, this.property, this.onUpdate, this.enabled = false})
      : super(key: key);

  @override
  _CameraTogglePropertyWidgetState createState() =>
      _CameraTogglePropertyWidgetState();
}

class _CameraTogglePropertyWidgetState extends State<CameraTogglePropertyWidget>
    with SingleTickerProviderStateMixin {
  bool isSelected;

  AnimationController _controller;
  Animation<double> _size;

  // @override
  // void didUpdateWidget(covariant CameraTogglePropertyWidget oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   isSelected = oldWidget.property.value;
  // }

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
  void dispose() {
    _controller.dispose();
    super.dispose();
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
      onPressed: !widget.property.readOnly && widget.enabled
          ? (int index) {
              setState(() {
                isSelected = !isSelected;
                if (isSelected)
                  _controller.forward();
                else
                  _controller.reverse();
              });
              if (widget.onUpdate != null) widget.onUpdate(isSelected);
            }
          : null,
      isSelected: [isSelected, !isSelected],
    );
  }
}

class CameraDateTimePropertyWidget extends StatefulWidget {
  final CameraDateProperty property;
  final ValueChanged<dynamic> onUpdate;
  final bool enabled;

  const CameraDateTimePropertyWidget(
      {Key key, this.property, this.onUpdate, this.enabled = false})
      : super(key: key);

  @override
  _CameraDateTimePropertyWidgetState createState() =>
      _CameraDateTimePropertyWidgetState();
}

class _CameraDateTimePropertyWidgetState
    extends State<CameraDateTimePropertyWidget> {
  TextEditingController _controller;
  DateFormat _format = DateFormat.yMMMd().add_jms();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: _format.format(DateTime(widget?.property?.value ?? 0)));
  }

  @override
  Widget build(BuildContext context) {
    return VCCSTextFormField(
        onTap: () async {
          var _date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(0),
              lastDate: DateTime(DateTime.now().year + 100));
          if (_date != null) {
            var time = await showTimePicker(
                context: context, initialTime: TimeOfDay.now());
            if (time != null) {
              _date = DateTime(
                  _date.year, _date.month, _date.day, time.hour, time.minute);
              setState(() {
                _controller.text = _format.format(_date);
              });
              if (widget.onUpdate != null) {
                widget.onUpdate(_date.millisecondsSinceEpoch);
              }
            }
          }
        },
        enabled: !widget.property.readOnly && widget.enabled,
        controller: _controller);
  }
}

class CameraRadioPropertyWidget extends StatefulWidget {
  final CameraRadioProperty property;
  final ValueChanged<dynamic> onUpdate;
  final bool enabled;

  const CameraRadioPropertyWidget(
      {Key key, this.property, this.onUpdate, this.enabled = false})
      : super(key: key);

  @override
  _CameraRadioPropertyWidgetState createState() =>
      _CameraRadioPropertyWidgetState();
}

class _CameraRadioPropertyWidgetState extends State<CameraRadioPropertyWidget> {
  dynamic groupValue;

  @override
  void initState() {
    super.initState();
    groupValue = widget.property.value;
  }

  Widget _radio(choice) {
    return Expanded(
      child: Row(
        children: [
          GestureDetector(
            onTap: () => setState(() => groupValue = choice),
            child: Radio(
              activeColor: Theme.of(context).primaryColor,
              groupValue: groupValue,
              onChanged: !widget.property.readOnly && widget.enabled
                  ? (value) {
                      setState(() => groupValue = value);
                      if (widget.onUpdate != null) widget.onUpdate(groupValue);
                    }
                  : null,
              value: choice.toString(),
            ),
          ),
          Text(choice.toString())
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [...widget.property.choices.map((e) => _radio(e)).toList()],
    );
  }
}

class CameraDropDownPropertyWidget extends StatefulWidget {
  final CameraDropDownProperty property;
  final ValueChanged<dynamic> onUpdate;
  final bool enabled;

  const CameraDropDownPropertyWidget(
      {Key key, this.property, this.onUpdate, this.enabled = false})
      : super(key: key);

  @override
  _CameraDropDownPropertyWidgetState createState() =>
      _CameraDropDownPropertyWidgetState();
}

class _CameraDropDownPropertyWidgetState
    extends State<CameraDropDownPropertyWidget> {
  dynamic val;

  @override
  void initState() {
    super.initState();
    val = widget.property.value;
  }

  @override
  Widget build(BuildContext context) {
    return VCCSDropDownTextField<dynamic>(
      options: widget.property.choices,
      value: val,
      getLabel: (l) => l.toString(),
      builder: (context, v, _) => Text(v.toString()),
      onChanged: !widget.property.readOnly && widget.enabled
          ? (v) {
              setState(() => val = v);
              if (widget.onUpdate != null) widget.onUpdate(val);
            }
          : null,
    );
  }
}
