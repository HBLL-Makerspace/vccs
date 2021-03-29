import 'dart:async';

enum MessageType { MESSAGE, ALERT, ERROR, SUCCESS }

class NotificationMessage {
  final String message;
  final String title;
  final Duration duration;
  final double width;
  final MessageType type;

  NotificationMessage(
    this.title, {
    this.message,
    this.duration = const Duration(milliseconds: 1000),
    this.width = 500,
    this.type = MessageType.MESSAGE,
  });
}

class NotificationMessenger {
  static StreamController<NotificationMessage> _messages =
      StreamController.broadcast();

  static void addNotification(NotificationMessage message) {
    _messages.add(message);
  }

  static Stream<NotificationMessage> onMessage() {
    return _messages.stream;
  }
}
