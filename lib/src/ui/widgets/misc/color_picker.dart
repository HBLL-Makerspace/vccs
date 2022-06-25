import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

Future<bool> colorPickerDialog(BuildContext context, Color color,
    ValueChanged<Color> onColorChanged) async {
  return ColorPicker(
    color: color,
    onColorChanged: onColorChanged,
    width: 40,
    height: 40,
    borderRadius: 4,
    spacing: 5,
    runSpacing: 5,
    wheelDiameter: 255,
    heading: Text(
      'Select color',
      style: Theme.of(context).textTheme.subtitle1,
    ),
    subheading: Text(
      'Select color shade',
      style: Theme.of(context).textTheme.subtitle1,
    ),
    wheelSubheading: Text(
      'Selected color and its shades',
      style: Theme.of(context).textTheme.subtitle1,
    ),
    showMaterialName: true,
    showColorName: true,
    showColorCode: true,
    materialNameTextStyle: Theme.of(context).textTheme.caption,
    colorNameTextStyle: Theme.of(context).textTheme.caption,
    // Showing color code prefix and text styled differently in the dialog.
    colorCodeTextStyle: Theme.of(context).textTheme.bodyText2,
    colorCodePrefixStyle: Theme.of(context).textTheme.caption,
    // Showing the new thumb color property option in dialog version
    selectedPickerTypeColor: Theme.of(context).colorScheme.primary,
    pickersEnabled: const <ColorPickerType, bool>{
      ColorPickerType.both: false,
      ColorPickerType.primary: true,
      ColorPickerType.accent: true,
      ColorPickerType.bw: false,
      ColorPickerType.custom: true,
      ColorPickerType.wheel: true,
    },
  ).showPickerDialog(
    context,
    constraints:
        const BoxConstraints(minHeight: 460, minWidth: 300, maxWidth: 320),
  );
}

Future<bool> intenseColorPickerDialog(BuildContext context, Color color,
    ValueChanged<Color> onColorChanged) async {
  return ColorPicker(
    color: color,
    onColorChanged: onColorChanged,
    width: 40,
    height: 40,
    borderRadius: 4,
    spacing: 5,
    runSpacing: 5,
    wheelDiameter: 255,
    heading: Text(
      'Select color',
      style: Theme.of(context).textTheme.subtitle1,
    ),
    subheading: Text(
      'Select color shade',
      style: Theme.of(context).textTheme.subtitle1,
    ),
    wheelSubheading: Text(
      'Selected color and its shades',
      style: Theme.of(context).textTheme.subtitle1,
    ),
    showMaterialName: true,
    showColorName: true,
    showColorCode: true,
    materialNameTextStyle: Theme.of(context).textTheme.caption,
    colorNameTextStyle: Theme.of(context).textTheme.caption,
    // Showing color code prefix and text styled differently in the dialog.
    colorCodeTextStyle: Theme.of(context).textTheme.bodyText2,
    colorCodePrefixStyle: Theme.of(context).textTheme.caption,
    // Showing the new thumb color property option in dialog version
    selectedPickerTypeColor: Theme.of(context).colorScheme.primary,
    pickersEnabled: const <ColorPickerType, bool>{
      ColorPickerType.both: false,
      ColorPickerType.primary: true,
      ColorPickerType.accent: true,
      ColorPickerType.bw: false,
      ColorPickerType.custom: true,
      ColorPickerType.wheel: true,
    },
  ).showPickerDialog(
    context,
    constraints:
        const BoxConstraints(minHeight: 460, minWidth: 300, maxWidth: 320),
  );
}
