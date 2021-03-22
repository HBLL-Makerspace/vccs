import 'package:test/test.dart';
import 'package:vccs/src/model/backend/implementations/libgphoto2/camera_controller.dart';
import 'package:vccs/src/model/backend/interfaces/camera_controller_interface.dart';
import 'package:vccs/src/model/backend/interfaces/camera_interface.dart';
import 'package:vccs/src/model/backend/path_provider.dart';

void main() {
  test("testing", () async {
    await PathProvider.init();
    ICameraController _controller = libgphoto2CameraController();
    List<ICamera> cameras = await _controller.getConnectedCameras();
    for (var cam in cameras)
      print("Camer: ${cam.getModel()}, serial number: ${cam.getId()}");
  });

  test("Liveview", () async {
    await PathProvider.init();
    ICameraController _controller = libgphoto2CameraController();
    List<ICamera> cameras = await _controller.getConnectedCameras();
    if (cameras.isNotEmpty) {
      expect(await _controller.startLiveView(cameras.first), equals(true));
      await Future.delayed(Duration(seconds: 10));
      expect(await _controller.stopLiveView(cameras.first), equals(true));
    } else {
      print("no cameras could not do test");
    }
  });
}
