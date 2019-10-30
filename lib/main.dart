import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:news_fluttter/config/page_manifest.dart';
import 'package:news_fluttter/provider/theme_model.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'language/language.dart';

const bool isRelease =
    const bool.fromEnvironment("dart.vm.product", defaultValue: false);

void reportErrorAndLog(FlutterErrorDetails details) {
  print(details);
}

void printLog(String log) {
  print(log);
}

FlutterErrorDetails makeErrorDetails(Object obj, StackTrace stackTrace) =>
    new FlutterErrorDetails(exception: "$obj", stack: stackTrace);

void main() {
  FlutterError.onError = (FlutterErrorDetails details) async {
    if (!isRelease) {
      reportErrorAndLog(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };
  runZoned(() {
    runApp(MyApp());
  },
//      zoneSpecification: new ZoneSpecification(
//      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
//    printLog(line);
//  }),
      onError: (Object obj, StackTrace stackTrace) {
    var details = makeErrorDetails(obj, stackTrace);
    reportErrorAndLog(details);
  });
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
    return ChangeNotifierProvider<ThemeModel>(builder: (_) {
      return ThemeModel();
    }, child: Consumer<ThemeModel>(builder: (context, themeModel, _) {
      return MaterialApp(
        onGenerateTitle: (context) => NewsLocalizations.of(context).title,
        theme: ThemeData(
            primarySwatch: themeModel.themeColor,
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
    }));
  }
}
