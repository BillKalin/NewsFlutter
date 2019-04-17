import 'package:flutter/material.dart';

class GridViewDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GridViewState();
}

class GridViewState extends State<GridViewDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GridViewDemo"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 1.0, crossAxisSpacing: 1.0, crossAxisCount: 3),
          itemBuilder: (context, index) {
            return Container(
              alignment: Alignment.center,
              child: Text(
                "grid($index)",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              color: Colors.blue,
            );
          },
          itemCount: 30,
        ),
      ),
    );
  }
}
