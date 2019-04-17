import 'package:flutter/material.dart';

class LayoutDemo extends StatefulWidget {
  LayoutDemo({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => LayoutState();
}

class LayoutState extends State<LayoutDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Hello "),
                Text(
                  "BillKalin",
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  color: Colors.blue,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        color: Colors.red,
                        child: Column(
                          mainAxisSize: MainAxisSize.max, //无效，内层Colum高度为实际高度
                          children: <Widget>[
                            Text("hello world "),
                            Text("I am Jack "),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.red,
                    height: 30,
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Container(
                    color: Colors.blue,
                    height: 30,
                  ),
                  flex: 2,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: SizedBox(
                height: 100,
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        color: Colors.amber,
                      ),
                      flex: 2,
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.red,
                        height: 30,
                      ),
                      flex: 1,
                    )
                  ],
                ),
              ),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: <Widget>[
                Chip(
                  label: Text("A" * 2),
                  avatar: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text("A"),
                  ),
                ),
                Chip(
                  label: Text("B" * 8),
                  avatar: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text("B"),
                  ),
                ),
                Chip(
                  label: Text("C" * 10),
                  avatar: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text("C"),
                  ),
                ),
                Chip(
                  label: Text("D" * 2),
                  avatar: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text("D"),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
