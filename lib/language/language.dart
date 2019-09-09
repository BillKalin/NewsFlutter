import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Language {}

class NewsLocalizations {
  final Locale locale;

  NewsLocalizations(this.locale);

  static NewsLocalizations of(BuildContext context) {
    var lo =  Localizations.of<NewsLocalizations>(context, NewsLocalizations);
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

class NewsLocalizationsDelegate
    extends LocalizationsDelegate<NewsLocalizations> {
  const NewsLocalizationsDelegate();

  static const supportLocale = [
    const Locale('zh'), // Chinese
    const Locale('en'), // English
  ];

  @override
  bool isSupported(Locale locale) =>
      ['en','zh'].contains(locale.languageCode);

  @override
  Future<NewsLocalizations> load(Locale locale) {
    return SynchronousFuture<NewsLocalizations>(NewsLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<NewsLocalizations> old) => false;
}
