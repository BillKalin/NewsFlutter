import 'package:flutter/material.dart';

//父widget管理子widget的state
class TapBoxB extends StatefulWidget {
  TapBoxB({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ParentState();
}

class ParentState extends State<TapBoxB> {
  bool _active = false;

  _handleBoxChange(bool active) {
    setState(() {
      _active = active;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: SubState(
        active: _active,
        onChange: _handleBoxChange,
      ),
    );
  }
}

class SubState extends StatelessWidget {
  SubState({Key key, this.active: false, @required this.onChange})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChange;

  void _handleTap() {
    onChange(!active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
        child: Center(
          child: Text(
            active ? "Actived" : "InActive",
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
