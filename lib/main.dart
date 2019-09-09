import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
import 'package:news_fluttter/WillPopScopeDemo.dart';
import 'package:news_fluttter/home_page.dart' as prefix0;
import 'package:news_fluttter/news/page/home_page.dart';
import 'package:news_fluttter/config/page_manifest.dart';
import 'RandomWordPage.dart';
import 'TapBoxA.dart';
import 'TapboxB.dart';
import 'TapBoxC.dart';
import 'home_page.dart';
import 'language/language.dart';
import 'news/page/screen_page.dart';
import 'news/page/video_page.dart';

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
//  debugPaintSizeEnabled = true;
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
  final Map<TargetPlatform, PageTransitionsBuilder> _defaultBuilders =
      <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => NewsLocalizations.of(context).title,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          pageTransitionsTheme:
              PageTransitionsTheme(builders: _defaultBuilders)),
      home: MainHomePage(),
//      routes: Routes.routesMap,
      onGenerateRoute: Routes.routes,
      localizationsDelegates: [
        const NewsLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: NewsLocalizationsDelegate.supportLocale,
    );
  }
}
