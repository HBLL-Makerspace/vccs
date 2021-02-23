import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

class VCCSDropDownTextField<T> extends StatelessWidget {
  final String hintText;
  @required
  final List<T> options;
  @required
  final T value;
  @required
  final String Function(T) getLabel;
  final void Function(T) onChanged;
  @required
  final ValueWidgetBuilder builder;

  const VCCSDropDownTextField(
      {Key key,
      this.hintText,
      this.options,
      this.value,
      this.getLabel,
      this.onChanged,
      this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      builder: (FormFieldState<T> state) {
        return InputDecorator(
          isEmpty: value == null,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8.0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              filled: true,
              labelText: hintText,
              fillColor: TinyColor(Colors.grey).darken(45).color),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isDense: true,
              onChanged: onChanged,
              items: options.map((T value) {
                return DropdownMenuItem<T>(
                  value: value,
                  child: builder(context, value, null),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
