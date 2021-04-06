import 'package:flutter/material.dart';

import 'package:vccs/src/ui/widgets/widgets.dart';
import 'package:vccs/src/model/backend/backend.dart';

class ProjectWelcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Project Welcome"),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: VCCSRaisedButton(
            child: Text("Test success notification"),
            onPressed: () {
              NotificationMessenger.addNotification(
                NotificationMessage("Success",
                    type: MessageType.SUCCESS,
                    message:
                        "This is a successful message, the snackbar should be a nice green color."),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: VCCSRaisedButton(
            child: Text("Test failed notification"),
            onPressed: () {
              NotificationMessenger.addNotification(NotificationMessage(
                  "Failed",
                  type: MessageType.ERROR,
                  message:
                      "Error messages are red, this is when something bad happens."));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: VCCSRaisedButton(
            child: Text("Test normal notification"),
            onPressed: () {
              NotificationMessenger.addNotification(NotificationMessage(
                  "Message",
                  type: MessageType.MESSAGE,
                  message:
                      "Normal messages are a similar grey to the background to prevent distraction."));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: VCCSRaisedButton(
            child: Text("Test alert notification"),
            onPressed: () {
              NotificationMessenger.addNotification(NotificationMessage("Alert",
                  type: MessageType.ALERT,
                  message:
                      "This is not as bad as error, just a way to tell the user something unexpected happened"));
            },
          ),
        ),
      ],
    );
  }
}
