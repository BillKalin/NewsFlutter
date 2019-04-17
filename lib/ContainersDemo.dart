import 'package:flutter/material.dart';

class ContainersDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ContainersState();
}

class ContainersState extends State<ContainersDemo> {
  @override
  Widget build(BuildContext context) {
    Widget redbox = DecoratedBox(decoration: BoxDecoration(color: Colors.red));

    return Scaffold(
      appBar: AppBar(
        title: Text("ContainersDemo"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 100,
                minWidth: double.infinity,
              ),
              child: Container(
                height: 50,
                child: redbox,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 50,
                  height: 50,
                  child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.blue)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ConstrainedBox(
                  constraints: BoxConstraints.tight(Size(80, 40)),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.amberAccent,
                        gradient: LinearGradient(
                            colors: [Colors.red, Colors.orange[700]]),
                        borderRadius: BorderRadius.circular(4.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(2, 2),
                            blurRadius: 4.0,
                          ),
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Test",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Container",
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
              margin: EdgeInsets.only(top: 20, left: 50),
              constraints: BoxConstraints.tightFor(width: 200, height: 120),
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [Colors.red, Colors.orange],
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black54,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 4.0),
                ],
              ),
              transform: Matrix4.rotationZ(.2),
            ),
          ],
        ),
      ),
    );
  }
}
