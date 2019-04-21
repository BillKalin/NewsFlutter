import 'package:flutter/material.dart';
import 'package:news_fluttter/news/NewsDetailPage.dart';
import 'package:news_fluttter/news/constants/Api.dart';
import 'package:news_fluttter/news/model/BaseReponse.dart';
import 'package:news_fluttter/news/model/NewsDetail.dart';
import 'package:news_fluttter/news/network/NetUtils.dart';

class NewsListPage extends StatefulWidget {
  final String title;
  final String categoryId;

  NewsListPage({Key key, this.title, this.categoryId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewsListState();
}

class _NewsListState extends State<NewsListPage> {
  List<NewsDetail> _newsList = [];
  int _page = 1;
  ScrollController _scrollController;
  static final LOADING_ITEM = NewsDetail(id: "-1");
  static final NO_MORE_ITEM = NewsDetail(id: "-2");

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent) {
        //加载更多
        _page += 1;
        fetchNewsDetail();
      } else if (_scrollController.offset <=
          _scrollController.position.minScrollExtent) {
        //到头部了
      }
    });
    fetchNewsDetail();
  }

  void fetchNewsDetail() {
    String path = Api.NEWS_LIST_URL
        .replaceAll("%1s", widget.categoryId)
        .replaceAll("%2s", _page.toString());

    print("path = $path");
    Future data = NetUtils.get(path);
    data.then((source) {
      var response = BaseResponse.fromJson(source);
      if (response.error) {
        return new List<NewsDetail>();
      } else {
        return NewsDetail.parseJson(response.results);
      }
    }).then((list) {
      setState(() {
        if (_newsList.length > 0) {
          _newsList.removeLast();
        }
        if (list.isEmpty) {
          _newsList.add(NO_MORE_ITEM);
        } else {
          _newsList.addAll(list);
          _newsList.add(LOADING_ITEM);
        }
      });
    });
  }

  void _handleOnItemClick(int index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return NewsDetailPage(
          title: _newsList[index].title, url: _newsList[index].url);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _newsList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              physics: BouncingScrollPhysics(),
              controller: _scrollController,
              itemBuilder: (context, index) {
                if (index == _newsList.length - 1) {
                  Widget lastChild;
                  if (NO_MORE_ITEM == _newsList[index]) {
                    lastChild = Text("没有更多了～");
                  } else if (LOADING_ITEM == _newsList[index]) {
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
                  title: Text(_newsList[index].title),
                  onTap: () => _handleOnItemClick(index),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 1,
                );
              },
              itemCount: _newsList.length),
    );
  }
}
