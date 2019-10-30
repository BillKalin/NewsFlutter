import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_fluttter/news/constant/constant.dart';
import 'package:news_fluttter/news/page/home_page.dart';

class ScreenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Colors.lightBlueAccent, Colors.blue]),
            ),
            child: Center(child: AnimatedLogo())),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 16),
              child: Text(
                "News Flutter",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    decoration: TextDecoration.none),
              ),
            )),
        SafeArea(
          child: Align(
            alignment: Alignment.topRight,
            child: CountDownText(
              context: context,
              animation: StepTween(begin: 6, end: 0).animate(_controller),
            ),
          ),
        ),
      ],
    );
  }
}

class AnimatedLogo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  Animation _animation;
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
//    _controller.addStatusListener((AnimationStatus status) {});
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      child: Image.asset(
        "assets/app_icon.png",
        width: 70,
        height: 70,
      ),
      scale: _animation,
    );
  }
}

class CountDownText extends AnimatedWidget {
  final Animation<int> animation;

  CountDownText({Key key, BuildContext context, this.animation})
      : super(key: key, listenable: animation) {
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _nextPage(context);
      }
    });
  }

  void _nextPage(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
      return HomePage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    var value = animation.value;
    return
        Container(
      padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
      margin: EdgeInsets.only(top: 12, right: 12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child:
        Material(
      type: MaterialType.card,
      borderRadius: BorderRadius.circular(20),
      child: Container(
          padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
//          margin: EdgeInsets.only(top: 12, right: 12),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: InkWell(
            onTap: () {
              _nextPage(context);
            },
            child: Text(
              "Skip(${value}s)",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  decoration: TextDecoration.none),
            ),
          )),
    ));
  }
}
