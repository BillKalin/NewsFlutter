import 'package:flutter/material.dart';
import 'package:news_fluttter/news/page/NewsSearchPage.dart';
import 'package:news_fluttter/news/widget/SearchWidget.dart';

class NewsHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          color: Theme.of(context).primaryColor,
          child: Row(
            children: <Widget>[
              Expanded(
                  child: SearchWidget(
                hindText: "input search keywords",
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return NewsSearchPage();
                  }));
                },
                onSubmitted: (String text) {},
              )),
            ],
          ),
        ),
      ],
    ));
  }
}
