import 'package:vccs/src/model/backend/interfaces/interfaces.dart';

abstract class ICameraController {
  Future<ICamera> getConnectedCameras();
}
