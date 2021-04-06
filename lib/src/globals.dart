import 'model/backend/backend.dart';
import 'model/domain/domian.dart';

ICameraController controller = libgphoto2CameraController();
Configuration configuration = Configuration();
List<ICamera> cameras = [];
