import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:vccs/src/blocs/settings_bloc/settings_bloc.dart';
import 'package:vccs/src/model/backend/backend.dart';

const CMD_WHITE = 0x03;
const CMD_COLOR = 0x02;

class RingLightController implements IMultiCameraCapture {
  SerialPort port;
  SettingsBloc settings;

  RingLightController(this.settings);

  @override
  Future<void> autofocus([bool autofocus]) {}

  @override
  Future<void> capture() async {
    print("Setting auto focus lighting: ${settings.autofocusLighting.value}");
    for (int i = 1; i >= 0; i--) {
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

      for (int j = 0; j < 3; j++) {
        bytes =
            Uint8List.fromList([0xff, i, CMD_WHITE, j, white_intensity, 0x00]);
        port.write(bytes);
        port.flush();
        await Future.delayed(Duration(milliseconds: 10));

        // print("r: $r, g: $g, b: $b");

        // bytes = Uint8List.fromList([0xff, i, CMD_COLOR, j, r, g, b, 0x00]);
        // print(bytes);
        // port.write(bytes);
        // port.flush();
        // await Future.delayed(Duration(milliseconds: 10));
        // bytes = Uint8List.fromList([0xff, 0, CMD_COLOR, j, r, g, b, 0x00]);
        print(bytes);
        port.write(Uint8List.fromList([0xff]));
        port.flush();
        await Future.delayed(Duration(milliseconds: 1));
        port.write(Uint8List.fromList([i]));
        port.flush();
        await Future.delayed(Duration(milliseconds: 1));
        port.write(Uint8List.fromList([CMD_COLOR]));
        port.flush();
        await Future.delayed(Duration(milliseconds: 1));
        port.write(Uint8List.fromList([j]));
        port.flush();
        await Future.delayed(Duration(milliseconds: 1));
        port.write(Uint8List.fromList([r]));
        port.flush();
        await Future.delayed(Duration(milliseconds: 1));
        port.write(Uint8List.fromList([g]));
        port.flush();
        await Future.delayed(Duration(milliseconds: 1));
        port.write(Uint8List.fromList([b]));
        port.flush();
        await Future.delayed(Duration(milliseconds: 1));
        port.write(Uint8List.fromList([0x00]));
        port.flush();
        await Future.delayed(Duration(milliseconds: 10));
      }
      // await Future.delayed(Duration(milliseconds: 1));
      // bytes = Uint8List.fromList([0xff, i, CMD_COLOR, 0x01, r, g, b, 0x00]);
      // port.write(bytes);
      // port.flush();
      // await Future.delayed(Duration(milliseconds: 1));
      // bytes = Uint8List.fromList([0xff, i, CMD_COLOR, 0x02, r, g, b, 0x00]);
      // port.write(bytes);
      // port.flush();
      // await Future.delayed(Duration(milliseconds: 1));
      // bytes = Uint8List.fromList([0xff, i, CMD_COLOR, 0x03, r, g, b, 0x00]);
      // port.write(bytes);
      // port.flush();
      // await Future.delayed(Duration(milliseconds: 1));
      // bytes = Uint8List.fromList([0xff, i, CMD_COLOR, 0x04, r, g, b, 0x00]);
      // port.write(bytes);
      // port.flush();
      // await Future.delayed(Duration(milliseconds: 1));
      // bytes = Uint8List.fromList([0xff, i, CMD_COLOR, 0x05, r, g, b, 0x00]);
      // port.write(bytes);
      // port.flush();
      // await Future.delayed(Duration(milliseconds: 10));
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
