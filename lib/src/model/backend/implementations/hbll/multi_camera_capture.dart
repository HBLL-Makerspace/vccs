import 'dart:typed_data';

// import 'package:flutter_serial_port/flutter_serial_port.dart';

import 'package:vccs/src/model/backend/backend.dart';

class HbllMultiCameraCapture implements IMultiCameraCapture {
  // SerialPort _port;

  @override
  Future<void> capture() async {
    print("Capturing images");
    // if (_port != null) {
    //   await Future.delayed(Duration(milliseconds: 100));
    //   _port.write(Uint8List.fromList([0xf0]));
    //   _port.flush();
    //   await Future.delayed(Duration(milliseconds: 5000));
    //   _port.write(Uint8List.fromList([0xc0]));
    //   _port.flush();
    //   await Future.delayed(Duration(milliseconds: 1000));
    //   _port.write(Uint8List.fromList([0xc1, 0xf1]));
    //   _port.flush();
    // }
  }

  @override
  Future<void> autofocus([bool autofocus]) {
    print("Trying to autofocus");
    // throw UnimplementedError();
  }

  void test() async {}

  @override
  Future<void> initialize() async {
    // print(SerialPort.availablePorts);
    // _port = SerialPort("/dev/ttyUSB0");
    // _port.openReadWrite();

    // var _reader = SerialPortReader(_port);
    // _reader.stream.listen((event) {
    //   print(String.fromCharCodes(event));
    // });
  }
}
