import 'package:flutter/material.dart';
import 'package:news_fluttter/news/constants/Api.dart';
import 'package:news_fluttter/news/model/TodayData.dart';
import 'package:news_fluttter/news/model/TodayItem.dart';
import 'package:news_fluttter/news/network/NetUtils.dart';
import 'package:news_fluttter/news/page/NewsDetailPage.dart';
import 'package:news_fluttter/news/page/NewsSearchPage.dart';
import 'package:news_fluttter/news/widget/SearchWidget.dart';
import 'package:video_player/video_player.dart';

class NewsHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  List<TodayItem> _list = [];

  @override
  void initState() {
    super.initState();
    _fetchTodayData();
  }

  void _fetchTodayData() {
    NetUtils.get(Api.TODAY_DATA).then((dynamic) {
      return TodayData.fromJson(dynamic);
    }).then((data) {
      print("size = ${data.results.length} & data = $data ");
      setState(() {
        if (data.error || data.results.isEmpty) {
          _list = [];
        } else {
          _list = data.results;
        }
      });
    });
  }

  void _handleItemClick(TodayItem item) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return NewsDetailPage(
        title: item.desc,
        url: item.url,
      );
    }));
  }

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
        Expanded(
          child: _list.isEmpty
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    TodayItem item = _list[index];
                    if ("休息视频" == item.type) {
                      return VideoPlayer(
                          VideoPlayerController.network(item.url));
                    } else if (item.images != null && item.images.isNotEmpty) {}
                    return ListTile(
                      title: Text(item.desc),
                      subtitle: Row(
                        children: <Widget>[
                          Text(item.who),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            padding: EdgeInsets.only(
                                left: 8, right: 8, top: 4, bottom: 4),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Text(
                              item.type,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        _handleItemClick(item);
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 1,
                    );
                  },
                  itemCount: _list.length),
        ),
      ],
    ));
  }
}
