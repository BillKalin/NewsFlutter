import 'package:flutter/material.dart';

class EventAndNotify extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EventAndNotifyState();
}

class EventAndNotifyState extends State<EventAndNotify> {
  PointerEvent _event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event and Notify"),
      ),
      body: Column(
        children: <Widget>[
          Listener(
            onPointerDown: (event) {
              setState(() {
                _event = event;
              });
              print("onPointerDown: $event");
            },
            onPointerMove: (event) => setState(() => _event = event),
            onPointerUp: (event) => setState(() => _event = event),
            onPointerCancel: (event) => setState(() => _event = event),
            child: Container(
              alignment: Alignment.center,
              width: 200,
              height: 100,
              color: Colors.blue,
              child: Text(
                _event?.position.toString() ?? "",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Listener(
            child: Container(
              color: Colors.amberAccent,
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(Size(300, 150)),
                child: Center(
                  child: Text("Box A"),
                ),
              ),
            ),
            onPointerDown: (event) {
              print("box A");
            },
            behavior: HitTestBehavior.opaque,
          ),
          Stack(
            children: <Widget>[
              Listener(
                child: ConstrainedBox(
                  constraints: BoxConstraints.tight(Size(300, 200)),
                  child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.blue)),
                ),
                onPointerDown: (event) {
                  print("down0");
                },
              ),
              Listener(
                child: ConstrainedBox(
                  constraints: BoxConstraints.tight(Size(200.0, 100.0)),
                  child: Center(child: Text("左上角200*100范围内非文本区域点击")),
                ),
                onPointerDown: (event) {
                  print("down1");
                },
                behavior: HitTestBehavior.translucent,
              ),
            ],
          ),
          Listener(
            child: IgnorePointer(//AbsorbPointer
              child: Listener(
                child: Container(
                  width: 200,
                  height: 100,
                  color: Colors.red,
                ),
                onPointerDown: (event) {
                  print("in");
                },
              ),
            ),
            onPointerDown: (event) {
              print("up");
            },
          ),
        ],
      ),
    );
  }
}
