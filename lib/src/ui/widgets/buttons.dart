import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

class VCCSRaisedButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final Color color;

  const VCCSRaisedButton({Key key, this.child, this.onPressed, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
      onPressed: onPressed,
      child: child,
      color: color,
    );
  }
}

class VCCSFlatButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final Color hoverColor;
  final EdgeInsets padding;

  const VCCSFlatButton(
      {Key key, this.child, this.onPressed, this.hoverColor, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      padding: padding ?? EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
      onPressed: onPressed,
      child: child,
      hoverColor: hoverColor != null
          ? TinyColor(hoverColor)?.setOpacity(0.2)?.color
          : Theme.of(context).accentColor,
    );
  }
}

class PlopFlatIconButton extends StatelessWidget {
  final Widget label;
  final Widget icon;
  final Function onPressed;
  final Color hoverColor;

  const PlopFlatIconButton(
      {Key key, this.onPressed, this.hoverColor, this.label, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
      onPressed: onPressed,
      hoverColor: hoverColor != null
          ? TinyColor(hoverColor)?.setOpacity(0.2)?.color
          : Theme.of(context).accentColor,
      icon: icon,
      label: label,
    );
  }
}

class PlopOutlineStadiumButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final Color hoverColor;

  const PlopOutlineStadiumButton(
      {Key key, this.child, this.onPressed, this.hoverColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
      onPressed: onPressed,
      child: child,
      hoverColor: hoverColor != null
          ? TinyColor(hoverColor)?.setOpacity(0.2)?.color
          : Theme.of(context).accentColor,
    );
  }
}
