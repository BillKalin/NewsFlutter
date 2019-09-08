import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Language {}

class DemoLocalizations {
  final Locale locale;

  DemoLocalizations(this.locale);

  static DemoLocalizations of(BuildContext context) {
    var lo =  Localizations.of<DemoLocalizations>(context, DemoLocalizations);
    print("${(lo == null).toString()} is null !!!");
    return lo;
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'Flutter Demo',
      'news': 'News',
    },
    'zh': {
      'title': 'Flutter示例',
      'news': '新闻',
    }
  };

  String get title => _localizedValues[locale.languageCode]['title'];

  String get news_title => _localizedValues[locale.languageCode]['news'];
}

class DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  static const supportLocale = [
    const Locale('zh'), // Chinese
    const Locale('en'), // English
  ];

  @override
  bool isSupported(Locale locale) =>
      ['en','zh'].contains(locale.languageCode);

  @override
  Future<DemoLocalizations> load(Locale locale) {
    return SynchronousFuture<DemoLocalizations>(DemoLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<DemoLocalizations> old) => false;
}
