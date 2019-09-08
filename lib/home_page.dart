import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_fluttter/config/page_manifest.dart';
import 'package:news_fluttter/language/language.dart';

import 'FileDemo.dart';
import 'JsonDemo.dart';
import 'LayoutDemo.dart';
import 'MethodChannel.dart';
import 'Network.dart';
import 'ScaffoldDemo.dart';
import 'ScrollWidgetDemo.dart';
import 'ThemeDemo.dart';
import 'news/page/video_page.dart';

class MainHomePage extends StatefulWidget {
  final String title;

  MainHomePage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(DemoLocalizations.of(context).news_title),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.splash);
              },
              child: Text("Demo App"),
            ),
          ),
          IconButton(
              icon: Icon(Icons.view_array),
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.news_detail);
              }),
          IconButton(
              icon: Icon(Icons.adjust),
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.news_detail);
              }),
          IconButton(
              icon: Icon(Icons.rate_review),
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.random_word_page);
              }),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.login);
            },
            child: Text("Login"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LayoutDemo(title: "Layout");
              }));
            },
            child: Text("Layout"),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.random_word_page);
              },
              child: Text("Container Demo"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ScaffoldDemo();
                }));
              },
              child: Text("Scofd"),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ScrollWidgetDemo();
                }));
              },
              child: Text("ScrollWidget"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, "ListView");
              },
              child: Text("ListView"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, "GridView");
              },
              child: Text("GridView"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, "CustomScrollViewDemo");
              },
              child: Text("CustomScrollView"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, "WillPopScopeDemo");
              },
              child: Text("WillPopSCope"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, "InheritedWidgetDemo");
              },
              child: Text("InheritedWidge"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, "ThemeDemo");
              },
              child: Text("Theme"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, "Event");
              },
              child: Text("Event and Notify"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, "Gesture");
              },
              child: Text("Gesture"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, "Notification");
              },
              child: Text("Notification"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, "Anim");
              },
              child: Text("Animation"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: RaisedButton(
              onPressed: () {
//                Navigator.pushNamed(context, "Anim");
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (BuildContext context) {
                  return ThemeDemo();
                }));
              },
              child: Text("PageRoute"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: RaisedButton(
              onPressed: () {
//                Navigator.pushNamed(context, "Anim");
                Navigator.of(context).push(PageRouteBuilder(pageBuilder:
                    (BuildContext context, Animation<double> animation,
                        Animation<double> secondaryAnimation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ThemeDemo(),
                  );
                }));
              },
              child: Text("SelfPageRoute"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: RaisedButton(
              onPressed: () {
//                Navigator.pushNamed(context, "Anim");
                Navigator.of(context).push(MyPageRoute(builder: (context) {
                  return ThemeDemo();
                }));
              },
              child: Text("MyPageRoute"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, "Hero");
              },
              child: Text("Hero Animation"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, "AnimPro");
              },
              child: Text("AnimationPro"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FileDemo();
                }));
              },
              child: Text("File Demo"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Network();
                }));
              },
              child: Text("Network Demo"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return JsonDemo();
                }));
              },
              child: Text("Json Demo"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MethodChannelDemo();
                }));
              },
              child: Text("Method Channel"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return VideoPage();
                }));
              },
              child: Text("Video Player"),
            ),
          ),
        ],
      ),
    );
  }
}


class MyPageRoute extends PageRoute {
  MyPageRoute({
    @required this.builder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
  });

  final WidgetBuilder builder;

  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color barrierColor;

  @override
  final String barrierLabel;

  @override
  final bool maintainState;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: builder(context),
    );
  }
}


class MyPageRouteBuilder extends PageTransitionsBuilder {

  const MyPageRouteBuilder();

  @override
  Widget buildTransitions<T>(PageRoute<T> route, BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

}
