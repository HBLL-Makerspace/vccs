class TetherFailedException implements Exception {
  final String reason;

  TetherFailedException(this.reason);
}
