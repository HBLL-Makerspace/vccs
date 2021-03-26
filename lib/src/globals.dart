import 'package:vccs/src/model/domain/configuration.dart';

import 'model/backend/implementations/implementations.dart';
import 'model/backend/interfaces/camera_controller_interface.dart';

ICameraController controller = libgphoto2CameraController();
Configuration configuration = Configuration();
