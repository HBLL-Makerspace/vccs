import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:vccs/src/blocs/settings_bloc/settings_bloc.dart';
import 'package:vccs/src/model/backend/backend.dart';

const CMD_FOCUS_SHUTTER = 0x05;
const CMD_WHITE = 0x03;
const CMD_COLOR = 0x02;
const MAX_RINGLIGHT_INDEX = 34;
const INTENSITY_CHANGE_ME =
    35; //Do not move above 35 until on a 60 AMP circuit! (or 3 15/20 circuits. it needs 45 total amps for max potential)

class RingLightController implements IMultiCameraCapture {
  SerialPort port;
  SettingsBloc settings;

  RingLightController(this.settings);

  @override
  Future<void> autofocus([bool autofocus]) {}

  @override
  Future<void> capture() async {
    print("Setting auto focus lighting: ${settings.autofocusLighting.value}");
    int r, g, b;

    r = settings.autofocusLighting.red;
    g = settings.autofocusLighting.green;
    b = settings.autofocusLighting.blue;

    int white_intensity = min(r, g);
    white_intensity = min(white_intensity, b);

    //easter egg: cool lighting sequence
    //Jed, it was an honor to work on this project. Please send me some 3D renders you get finished!
    // -Jack Damiano, jack.damiano@gmail.com
    if (white_intensity == 0) {
      Uint8List bytes;
      //set lights going up in a spiral
      for (int i = 0; i < MAX_RINGLIGHT_INDEX; i++) {
        for (int j = 0; j < 3; j++) {
          bytes = Uint8List.fromList([0xff, i, CMD_WHITE, j, 30, 0x00]);
          port.write(bytes);
          port.flush();
          await Future.delayed(Duration(milliseconds: 5));
        }
      }

      await Future.delayed(Duration(milliseconds: 300));

      //turns lights off going down
      for (int i = MAX_RINGLIGHT_INDEX; i >= 0; i--) {
        for (int j = 0; j < 3; j++) {
          bytes = Uint8List.fromList([0xff, i, CMD_WHITE, j, 0, 0x00]);
          port.write(bytes);
          port.flush();
          await Future.delayed(Duration(milliseconds: 10));
        }
      }
    }

    //sets focus lights and focuses
    for (int i = MAX_RINGLIGHT_INDEX; i >= 0; i--) {
      Uint8List bytes;
      bytes = Uint8List.fromList([0xff, i, CMD_WHITE, 0, 5, 0x00]);
      port.write(bytes);
      port.flush();
      //await Future.delayed(Duration(milliseconds: 1));

      bytes = Uint8List.fromList([0xff, i, CMD_FOCUS_SHUTTER, 1, 0, 0x00]);
      port.write(bytes);
      port.flush();
      //await Future.delayed(Duration(milliseconds: 1));
    }

    //focus time; Can be adjusted
    await Future.delayed(Duration(milliseconds: 1000));

    //turns off focus lights
    for (int i = MAX_RINGLIGHT_INDEX; i >= 0; i--) {
      Uint8List bytes;
      bytes = Uint8List.fromList([0xff, i, CMD_WHITE, 0, 0, 0x00]);
      port.write(bytes);
      port.flush();
    }

    //takes picture
    for (int i = MAX_RINGLIGHT_INDEX; i >= 0; i--) {
      int r, g, b;

      r = settings.autofocusLighting.red;
      g = settings.autofocusLighting.green;
      b = settings.autofocusLighting.blue;

      int white_intensity = min(r, g);
      white_intensity = min(white_intensity, b);

      r = r - white_intensity;
      g = g - white_intensity;
      b = b - white_intensity;

      print("intensity: $white_intensity");
      Uint8List bytes;

      //set white LEDs for flash
      //for (int j = 0; j < 3; j++) {
      bytes = Uint8List.fromList(
          [0xff, i, CMD_WHITE, 1, INTENSITY_CHANGE_ME, 0x00]);
      port.write(bytes);
      port.flush();
      //await Future.delayed(Duration(milliseconds: 1));

      //if we have color data and that color data is new.
      //TODO: implement color on its OWN button. Have it update color data independently.
      //it appears that the color LEDs dont update correctly when we communicate to them in pieces.
      //the firmware needs a special buffer for color I believe. Needs lots of debugging
      // if ((r > 0 || g > 0 || b > 0)) {
      //   await Future.delayed(Duration(milliseconds: 100));

      //}
    }

    //takes picture
    for (int i = MAX_RINGLIGHT_INDEX; i >= 0; i--) {
      Uint8List bytes;
      bytes = Uint8List.fromList([0xff, i, CMD_FOCUS_SHUTTER, 0, 1, 0x00]);
      port.write(bytes);
      port.flush();
      //await Future.delayed(Duration(milliseconds: 1));
    }

    //wait for camera to take photos
    await Future.delayed(Duration(milliseconds: 100));

    //turns off lights
    for (int i = MAX_RINGLIGHT_INDEX; i >= 0; i--) {
      Uint8List bytes;

      //for (int j = 0; j < 3; j++) {
      bytes = Uint8List.fromList([0xff, i, CMD_WHITE, 1, 0, 0x00]);
      port.write(bytes);
      port.flush();
      //}

      await Future.delayed(Duration(milliseconds: 1));
    }

    // await Future.delayed(Duration(milliseconds: 2000));

    // for (int i = 35; i >= 0; i--) {
    //   Uint8List bytes = Uint8List.fromList([0xff, i, 0x05, 0x01, 0x01, 0x00]);
    //   port.write(bytes);
    //   port.flush();
    //   await Future.delayed(Duration(milliseconds: 1));
    // }
  }

  @override
  Future<void> initialize() {
    print(SerialPort.availablePorts);
    String portName = SerialPort.availablePorts[0];
    port = SerialPort("/dev/ttyUSB0");
    print("Opened Serial port $portName");
    port.openWrite();
    print("Baudrate: " + port.config.baudRate.toString());
  }
}
