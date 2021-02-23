import 'package:vccs/src/model/domain/domian.dart';

abstract class ICameraPropertyController {
  Future<Camera> getConnectedCameras();
}
