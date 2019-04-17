import 'package:flutter/material.dart';

class WillPopScopeDemo extends StatelessWidget {
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    DateTime _lastPressedAt; //上次点击时间

    Future<bool> popCheck() async {
      if (_lastPressedAt == null ||
          DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
        _lastPressedAt = DateTime.now();
        _key.currentState.showSnackBar(SnackBar(
          content: Text("press again to exit !!"),
          duration: Duration(seconds: 2),
        ));
        return false;
      }
      return true;
    }

    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("WillPopScope Demo"),
      ),
      body: WillPopScope(
          child: Container(
            alignment: Alignment.center,
            child: Text("Press again to exit!"),
          ),
          onWillPop: popCheck),
    );
  }
}
