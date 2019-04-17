import 'package:flutter/material.dart';

class HeroAnim extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("HeroAnim"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: InkWell(
          child: Hero(
            tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
            child: ClipOval(
              child: Image.asset(
                "assets/app_icon.png",
                width: 50.0,
              ),
            ),
          ),
          onTap: () {
            //打开B路由
            Navigator.push(context, PageRouteBuilder(pageBuilder:
                (BuildContext context, Animation animation,
                Animation secondaryAnimation) {
              return new FadeTransition(
                opacity: animation,
                child: NextPage(),
              );
            }));
          },
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(tag: "icon", child: Image.asset("assets/app_icon.png")),
    );
  }
}
