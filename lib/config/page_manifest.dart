import 'package:flutter/material.dart';
import 'package:news_fluttter/Login.dart';
import 'package:news_fluttter/news/page/screen_page.dart';

import '../AnimationDemo.dart';
import '../ComplexAnimation.dart';
import '../CustomScrollViewDemo.dart';
import '../EventAndNotify.dart';
import '../GestureDemo.dart';
import '../GridViewDemo.dart';
import '../HeroAnim.dart';
import '../InheritedWidgetDemo.dart';
import '../ListViewDemo.dart';
import '../News.dart';
import '../NotificationDemo.dart';
import '../RandomWordPage.dart';
import '../TapBoxA.dart';
import '../TapBoxC.dart';
import '../TapboxB.dart';
import '../ThemeDemo.dart';
import '../WillPopScopeDemo.dart';

class RouteNames {
  static const news_detail = "NewsDetail";
  static const random_word_page = "RandomWordPage";
  static const tabbox_a = "TabBoxA";
  static const tabbox_b = "TabBoxB";
  static const tabbox_c = "TabBoxC";
  static const listview = "ListView";
  static const gridview = "GridView";
  static const custom_scrollview_demo = "CustomScrollViewDemo";
  static const will_popscope_demo = "WillPopScopeDemo";
  static const inherited_widget_demo = "InheritedWidgetDemo";
  static const theme_demo = "ThemeDemo";
  static const event = "Event";
  static const gesture = "Gesture";
  static const notification = "Notification";
  static const anim = "Anim";
  static const hero = "Hero";
  static const animpro = "AnimPro";
  static const splash = "Splash";
  static const login = "Login";
}

class Routes {
  static Route<dynamic> routes(RouteSettings settings) {
    return MaterialPageRoute(builder: routesMap[settings.name]);
  }

  static Map<String, WidgetBuilder> routesMap = {
    RouteNames.news_detail: (context) => NewsDetail(),
    RouteNames.random_word_page: (context) => RandomWordPage(),
    RouteNames.tabbox_a: (context) => TapBoxA(),
    RouteNames.tabbox_b: (context) => TapBoxB(),
    RouteNames.tabbox_c: (context) => TapBoxC(),
    RouteNames.listview: (context) => ListViewDemo(),
    RouteNames.gridview: (context) => GridViewDemo(),
    RouteNames.custom_scrollview_demo: (context) => CustomScrollViewDemo(),
    RouteNames.will_popscope_demo: (context) => WillPopScopeDemo(),
    RouteNames.inherited_widget_demo: (context) => InheritedWidgetDemo(),
    RouteNames.theme_demo: (context) => ThemeDemo(),
    RouteNames.event: (context) => EventAndNotify(),
    RouteNames.gesture: (context) => GestureDemo(),
    RouteNames.notification: (context) => NotificationDemo(),
    RouteNames.anim: (context) => AnimationDemo(),
    RouteNames.hero: (context) => HeroAnim(),
    RouteNames.animpro: (context) => ComplexAnimation(),
    RouteNames.splash: (context) => ScreenPage(),
    RouteNames.login: (context) => Login(),
  };
}
