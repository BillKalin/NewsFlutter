import 'package:flutter/material.dart';
import 'package:news_fluttter/news/page/NewsDetailPage.dart';
import 'package:news_fluttter/news/constants/Api.dart';
import 'package:news_fluttter/news/model/BaseReponse.dart';
import 'package:news_fluttter/news/model/SearchItem.dart';
import 'package:news_fluttter/news/network/NetUtils.dart';
import 'package:news_fluttter/news/widget/SearchWidget.dart';

class NewsSearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchState();
}

class _SearchState extends State<NewsSearchPage> {
  int _page = 1;
  List<SearchItem> _list = [];
  int groupValue = 1;

  @override
  void initState() {
    super.initState();
  }

  void fetchSearchResult(String keyword) {
    String path = Api.NEWS_SEARCH_URL
        .replaceAll("%1s", keyword)
        .replaceAll("%2s", "Android")
        .replaceAll("%3s", _page.toString());
    print("path = $path");

    Future request = NetUtils.get(path);
    request.then((source) {
      var response = BaseResponse.fromJson(source);
      if (response.error) {
        return new List<SearchItem>();
      } else {
        return SearchItem.parseJson(response.results);
      }
    }).then((data) {
      setState(() {
        _list = data;
      });
    });
  }

  void _handleClickItem(SearchItem item) {
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
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              color: Theme.of(context).primaryColor,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: SearchWidget(
                    hindText: "input text",
                    onTap: () {},
                    onSubmitted: (String text) {
                      fetchSearchResult(text);
                    },
                  )),
                ],
              ),
            ),
//            Column(
//              children: <Widget>[
//                Wrap(
//                  spacing: 8,
//                  runSpacing: 4,
//                  children: <Widget>[
//                    InputChip(
//                      label: Text("A" * 2),
//                      selected: true,
//                      avatar: CircleAvatar(
//                        backgroundColor: Colors.blue,
//                        child: Text("A"),
//                      ),
//                    ),
//                    InputChip(
//                      label: Text("B" * 8),
//                      avatar: CircleAvatar(
//                        backgroundColor: Colors.blue,
//                        child: Text("B"),
//                      ),
//                    ),
//                    InputChip(
//                      label: Text("C" * 10),
//                      avatar: CircleAvatar(
//                        backgroundColor: Colors.blue,
//                        child: Text("C"),
//                      ),
//                    ),
//                    InputChip(
//                      label: Text("D" * 2),
//                      avatar: CircleAvatar(
//                        backgroundColor: Colors.blue,
//                        child: Text("D"),
//                      ),
//                    )
//                  ],
//                ),
//              ],
//            ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    var item = _list[index];
                    return ListTile(
                      title: Text(item.desc),
                      subtitle: Text(item.who),
                      onTap: () {
                        _handleClickItem(item);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 1,
                    );
                  },
                  itemCount: _list.length),
            ),
          ],
        ),
      ),
    );
  }
}
