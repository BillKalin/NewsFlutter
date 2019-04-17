import 'package:flutter/material.dart';

class GestureDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DragGesture();
}

class GestureDemoState extends State<GestureDemo> {
  String _text = "no gesture detected";

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          width: 200,
          height: 100,
          color: Colors.blue,
          child: Text(
            _text,
            style: TextStyle(color: Colors.white),
          ),
        ),
        onTap: () => updateText("Click"),
        onLongPress: () => updateText("onLongPress"),
        onDoubleTap: () => updateText("onDoubleTap"),
      ),
    );
  }

  void updateText(String text) {
    setState(() {
      _text = text;
    });
  }
}

class DragGesture extends State<GestureDemo> {
  double _left = 0.0;
  double _top = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: _left,
          top: _top,
          child: GestureDetector(
            child: CircleAvatar(
              child: Text("A"),
            ),
            onPanDown: (DragDownDetails details) {
              print("drag start : ${details.globalPosition}");
            },
            onPanUpdate: (DragUpdateDetails details) {
              setState(() {
                _left += details.delta.dx;
                _top += details.delta.dy;
              });
            },
            onPanEnd: (DragEndDetails details) {
              print("drag end : ${details.velocity}");
            },
          ),
        ),
      ],
    );
  }
}
