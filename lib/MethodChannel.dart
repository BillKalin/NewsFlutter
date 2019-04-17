import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MethodChannelDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MethodChannelDemoState();
}

class MethodChannelDemoState extends State<MethodChannelDemo> {
  static const platform = MethodChannel("test_channel");

  String _batteryLevel = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBatteryLevel();
  }

  void getBatteryLevel() async {
    String level;
    try {
      int result = await platform.invokeMethod("getBatteryLevel");
      level = "current level : $result";
    } on MissingPluginException catch (e) {
      print(e);
      level = "get battery level error";
    }

    setState(() {
      _batteryLevel = level;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Method Channel"),
      ),
      body: Center(
        child: Text(_batteryLevel),
      ),
    );
  }
}
