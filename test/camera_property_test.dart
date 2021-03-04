import 'package:test/test.dart';

import '../lib/src/model/backend/backend.dart';

void main() {
  test("testing", () async {
    ICameraController _controller = libgphoto2CameraController();
    await _controller.getConnectedCameras();
  });
}
