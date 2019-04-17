import 'package:flutter/material.dart';

class NotificationDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotificationState();
}

class NotificationState extends State<NotificationDemo> {
  String msg = "";

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Builder(builder: (context) {
              return RaisedButton(
                onPressed: () {
                  MyNotification("send notification").dispatch(context);
                },
                child: Text("Send Notification"),
              );
            }),
            Text(msg),
          ],
        ),
      ),
      onNotification: (MyNotification notification) {
        setState(() {
          msg += notification.msg;
        });
      },
    );
  }
}

class MyNotification extends Notification {
  MyNotification(this.msg);

  final String msg;
}
