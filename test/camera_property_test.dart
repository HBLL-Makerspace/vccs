import 'package:test/test.dart';
import 'package:vccs/src/model/backend/implementations/camera_property_controller.dart';

void main() {
  test("testing", () async {
    CameraPropertyController _controller = CameraPropertyController();
    await _controller.getConnectedCameras();
  });
}
