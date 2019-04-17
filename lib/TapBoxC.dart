import 'package:flutter/material.dart';

class TapBoxC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ParentState2();
}

class ParentState2 extends State<TapBoxC> {
  bool _active = false;

  void _handleBoxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SubStateWidget(
        active: _active,
        onChanged: _handleBoxChanged,
      ),
    );
  }
}

class SubStateWidget extends StatefulWidget {
  SubStateWidget({Key key, this.active: false, @required this.onChanged});

  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  State<StatefulWidget> createState() {
    return SubStateC();
  }
}

class SubStateC extends State<SubStateWidget> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      this._highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      this._highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      this._highlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: _handleTap,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
            color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
            border: _highlight
                ? new Border.all(
              color: Colors.teal[700],
              width: 10.0,
            )
                : null),
        child: Center(
            child: new Text(widget.active ? 'Active' : 'Inactive',
                style: new TextStyle(fontSize: 32.0, color: Colors.white)),
        ),
      ),
    );
  }
}
