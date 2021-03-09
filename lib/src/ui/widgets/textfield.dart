import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tinycolor/tinycolor.dart';

class VCCSTextFormField extends StatelessWidget {
  final List<TextInputFormatter> inputFormatters;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String label;
  final int maxlines;
  final bool obscureText;
  final Widget suffixIcon;
  final AutovalidateMode autovalidateMode;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onSubmitted;
  final FocusNode focusNode;
  final bool enabled;
  final VoidCallback onTap;

  const VCCSTextFormField({
    Key key,
    this.onChanged,
    this.inputFormatters,
    this.label,
    this.maxlines = 1,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.autovalidateMode,
    this.validator,
    this.onSubmitted,
    this.focusNode,
    this.enabled = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // maxLines: multiline ? 5 : 1,
      controller: controller,
      onTap: onTap,
      focusNode: focusNode,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      maxLines: maxlines,
      decoration: InputDecoration(
        // isDense: true,
        enabled: enabled,
        alignLabelWithHint: true,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.all(8.0),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Theme.of(context).accentColor)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none),
        filled: true,
        labelText: label,
        fillColor: TinyColor(Colors.grey).darken(45).color,
      ),
      obscureText: obscureText,
      autovalidateMode: autovalidateMode,
      validator: validator,
      onFieldSubmitted: onSubmitted,
    );
  }
}
