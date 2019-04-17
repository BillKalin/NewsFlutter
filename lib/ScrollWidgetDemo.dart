import 'package:flutter/material.dart';

class ScrollWidgetDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScrollWidgetState();
}

class ScrollWidgetState extends State<ScrollWidgetDemo> {
  @override
  Widget build(BuildContext context) {
    String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return Scaffold(
      appBar: AppBar(
        title: Text("ScrollWidgetDemo"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: str.split("").map((s) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      s,
                      textScaleFactor: 2.0,
                    )
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
