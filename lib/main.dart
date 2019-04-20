import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_fluttter/AnimationDemo.dart';
import 'package:news_fluttter/ComplexAnimation.dart';
import 'package:news_fluttter/ContainersDemo.dart';
import 'package:news_fluttter/CustomScrollViewDemo.dart';
import 'package:news_fluttter/EventAndNotify.dart';
import 'package:news_fluttter/FileDemo.dart';
import 'package:news_fluttter/GestureDemo.dart';
import 'package:news_fluttter/GridViewDemo.dart';
import 'package:news_fluttter/HeroAnim.dart';
import 'package:news_fluttter/InheritedWidgetDemo.dart';
import 'package:news_fluttter/JsonDemo.dart';
import 'package:news_fluttter/LayoutDemo.dart';
import 'package:news_fluttter/ListViewDemo.dart';
import 'package:news_fluttter/Login.dart';
import 'package:news_fluttter/MethodChannel.dart';
import 'package:news_fluttter/Network.dart';
import 'package:news_fluttter/News.dart';
import 'package:news_fluttter/NotificationDemo.dart';
import 'package:news_fluttter/ScaffoldDemo.dart';
import 'package:news_fluttter/ScrollWidgetDemo.dart';
import 'package:news_fluttter/ThemeDemo.dart';
import 'package:news_fluttter/WidgetLife.dart';
import 'package:news_fluttter/WillPopScopeDemo.dart';
import 'package:news_fluttter/news/NewsMainPage.dart';
import 'RandomWordPage.dart';
import 'dart:async';
import 'TapBoxA.dart';
import 'TapboxB.dart';
import 'TapBoxC.dart';

void reportErrorAndLog(FlutterErrorDetails details) {
  print(details);
}

void printLog(String log) {
  print(log);
}

FlutterErrorDetails makeErrorDetails(Object obj, StackTrace stackTrace) =>
    new FlutterErrorDetails(exception: "$obj", stack: stackTrace);

void main() {
//  FlutterError.onError = (FlutterErrorDetails details) {
//    reportErrorAndLog(details);
//  };
//  runZoned(() {
  runApp(MyApp());
//  }, zoneSpecification: new ZoneSpecification(
//      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
//    printLog(line);
//  }), onError: (Object obj, StackTrace stackTrace) {
//    var details = makeErrorDetails(obj, stackTrace);
//    reportErrorAndLog(details);
//  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'News'),
      routes: {
        "NewsDetail": (context) => NewsDetail(),
        "RandomWordPage": (context) => RandomWordPage(),
        "TabBoxA": (context) => TapBoxA(),
        "TabBoxB": (context) => TapBoxB(),
        "TabBoxC": (context) => TapBoxC(),
        "ListView": (context) {
          return ListViewDemo();
        },
        "GridView": (context) => GridViewDemo(),
        "CustomScrollViewDemo": (context) => CustomScrollViewDemo(),
        "WillPopScopeDemo": (context) => WillPopScopeDemo(),
        "InheritedWidgetDemo": (context) => InheritedWidgetDemo(),
        "ThemeDemo": (context) => ThemeDemo(),
        "Event": (context) => EventAndNotify(),
        "Gesture": (context) => GestureDemo(),
        "Notification": (context) => NotificationDemo(),
        "Anim": (context) => AnimationDemo(),
        "Hero": (context) => HeroAnim(),
        "AnimPro": (context) => ComplexAnimation(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NewsMainPage();
                }));
              },
              child: Text("Demo App"),
            ),
          ),
          IconButton(
              icon: Icon(Icons.view_array),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return new NewsDetail();
                }));
              }),
          IconButton(
              icon: Icon(Icons.adjust),
              onPressed: () {
                Navigator.pushNamed(context, "NewsDetail");
              }),
          IconButton(
              icon: Icon(Icons.rate_review),
              onPressed: () {
                Navigator.pushNamed(context, "RandomWordPage");
              }),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Login();
              }));
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
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ContainersDemo();
                }));
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
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
