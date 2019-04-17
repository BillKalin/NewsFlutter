import 'package:flutter/material.dart';

class ComplexAnimation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ComplexAnimationState();
}

class ComplexAnimationState extends State<ComplexAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
  }

  Future<Null> _playAnimation() async {
    try {
      await _controller
          .forward()
          .orCancel;
      await _controller
          .reverse()
          .orCancel;
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(title: Text("ComplexAnimation"),), body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _playAnimation();
        },
        child: Center(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              border: Border.all(color: Colors.black.withOpacity(0.5)),
            ),
            child: ComplexAnimWidget(
              controller: _controller,
            ),
          ),
        ),
      ),);
  }
}

class ComplexAnimWidget extends StatelessWidget {
  ComplexAnimWidget({Key key, this.controller}) : super(key: key) {
    height = Tween<double>(begin: 0.0, end: 300.0).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.0, 0.6, curve: Curves.ease)));

    color = ColorTween(begin: Colors.green, end: Colors.red).animate(
        CurvedAnimation(
            parent: controller, curve: Interval(0.0, 0.6, curve: Curves.ease)));

    padding = Tween<EdgeInsets>(
        begin: EdgeInsets.only(left: 0.0),
        end: EdgeInsets.only(left: 100.0))
        .animate(CurvedAnimation(
        parent: controller, curve: Interval(0.6, 1.0, curve: Curves.ease)));
  }

  final AnimationController controller;
  Animation<double> height;
  Animation<Color> color;
  Animation<EdgeInsets> padding;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding.value,
      child: Container(
        color: color.value,
        width: 50.0,
        height: height.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: controller, builder: _buildAnimation);
  }
}
