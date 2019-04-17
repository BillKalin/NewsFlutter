import 'package:flutter/material.dart';

class AnimationDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScaleAnimState();
}

class AnimationDemoState extends State<AnimationDemo>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

  void initAnimation() {
    var ac = AnimationController(
        vsync: this,
        duration: Duration(seconds: 2),
        lowerBound: 0.0,
        upperBound: 1.0);

    final curve = CurvedAnimation(parent: ac, curve: Curves.easeInOut);

    final tw = IntTween(begin: 1, end: 255).animate(curve);
    tw.addListener(() {});
    tw.addStatusListener((AnimationStatus status) {});

    ac.forward();
  }
}

class ScaleAnimState extends State<AnimationDemo>
    with SingleTickerProviderStateMixin {
  double _width = 0.0, _height = 0.0;

  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
//    _animationController.addListener(() {
//      setState(() {
//        _width = _height = _animation.value;
//      });
//    });
    final curve = CurvedAnimation(
        parent: _animationController, curve: Curves.bounceInOut);
    _animation = Tween(begin: 1.0, end: 500.0).animate(curve);
//    _animation.addListener(() {
//      setState(() {
//        _width = _height = _animation.value;
//        print("width = $_width");
//      });
//    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GrowthImage(Image.asset("assets/app_icon.png"), _animation);

//    return AnimatedBuilder(
//      animation: _animation,
//      builder: (BuildContext ctx, Widget child) {
//        return Center(
//          child: Container(
//            child: child,
//            width: _animation.value,
//            height: _animation.value,
//          ),
//        );
//      },
//      child: Image.asset("assets/app_icon.png"),
//    );

//    return AnimatedImage(anim: _animation,);

//    return Center(
//      child: Image.asset(
//        "assets/app_icon.png",
//        width: _width,
//        height: _height,
//      ),
//    );
  }
}

class AnimatedImage extends AnimatedWidget {
  AnimatedImage({Key key, @required Animation anim})
      : super(key: key, listenable: anim);

  @override
  Widget build(BuildContext context) {
    Animation animation = listenable;

    return Center(
      child: Image.asset(
        "assets/app_icon.png",
        width: animation.value,
        height: animation.value,
      ),
    );
  }
}

class GrowthImage extends StatelessWidget {
  GrowthImage(this._child, this._animation);

  final Animation _animation;
  final Widget _child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget child) {
          return Container(
            child: child,
            width: _animation.value,
            height: _animation.value,
          );
        },
        child: _child,
      ),
    );
  }
}
