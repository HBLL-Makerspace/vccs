abstract class IMultiCameraCapture {
  Future<void> initialize();
  Future<void> capture();
  Future<void> autofocus([bool autofocus]);
}
