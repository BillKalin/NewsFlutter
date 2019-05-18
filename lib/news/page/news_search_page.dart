import 'package:flutter/material.dart';
import 'package:news_fluttter/news/constants/Api.dart';
import 'package:news_fluttter/news/model/base_reponse.dart';
import 'package:news_fluttter/news/model/search_item.dart';
import 'package:news_fluttter/news/network/net_utils.dart';
import 'package:news_fluttter/news/page/web_view_page.dart';
import 'package:news_fluttter/news/widget/SearchWidget.dart';

class NewsSearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchState();
}

class _SearchState extends State<NewsSearchPage> {
  static final _LOADING_ITEM = SearchItem(type: "loading");
  static final _NO_MORE_ITEM = SearchItem(type: "no_more");

  int _page = 1;
  List<SearchItem> _list = [];
  ScrollController _scrollController;
  String keyword = "";

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent) {
        //到达底部，加载更多
        _page += 1;
        fetchSearchResult(keyword, _page);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void fetchSearchResult(String keyword, int page) {
    String path = Api.NEWS_SEARCH_URL
        .replaceAll("%1s", keyword)
        .replaceAll("%2s", "all")
        .replaceAll("%3s", page.toString());
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
        print("data = $data");

        if (_list.isNotEmpty) {
          _list.removeLast();
        }
        if (page == 1) {
          _list = data;
        } else {
          if (data.isNotEmpty) {
            _list.addAll(data);
          }
        }
        if (data.isEmpty) {
          _list.add(_NO_MORE_ITEM);
        } else {
          _list.add(_LOADING_ITEM);
        }
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
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                color: Theme.of(context).primaryColor,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: SearchWidget(
                      hindText: "input search keywords",
                      onTap: () {},
                      onSubmitted: (String text) {
                        _page = 1;
                        keyword = text;
                        fetchSearchResult(text, _page);
                      },
                    )),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                    controller: _scrollController,
                    itemBuilder: (BuildContext context, int index) {
                      var item = _list[index];
                      if (index == _list.length - 1) {
                        Widget lastChild;
                        if (_NO_MORE_ITEM == _list[index]) {
                          lastChild = Text("没有更多了～");
                        } else if (_LOADING_ITEM == _list[index]) {
                          lastChild = SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                            ),
                          );
                        }
                        return Container(
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.center,
                          child: lastChild,
                        );
                      }
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
      ),
    );
  }
}
