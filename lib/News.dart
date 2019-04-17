import 'package:flutter/material.dart';

class NewsDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("NewsDetail")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text("I'm News Detail")],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.alarm), title: Text("Home")),
        BottomNavigationBarItem(icon: Icon(Icons.adjust), title: Text("Ajust")),
        BottomNavigationBarItem(icon: Icon(Icons.link), title: Text("Link"))
      ]),
    );
  }
}
