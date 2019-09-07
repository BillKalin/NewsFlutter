import 'package:flutter/material.dart';
import 'package:news_fluttter/news/constants/Api.dart';
import 'package:news_fluttter/news/model/Category.dart';
import 'package:news_fluttter/news/model/base_reponse.dart';
import 'package:news_fluttter/news/network/net_utils.dart';
import 'package:news_fluttter/news/page/news_category_list_page.dart';

class NewsMainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewMainState();
}

class _NewMainState extends State<NewsMainPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  List<Category> _list = [];
  int _currIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchCategoryList();
  }

  void fetchCategoryList() {
    Future<dynamic> task = NetUtils.get(Api.CATEGORY_URL);
    task.then((source) {
      var result = BaseResponse.fromJson(source);
      if (result.error) {
        return false;
      } else {
        return Category.parseJson(result.results);
      }
    }).then((ret) {
      if (ret is bool) {
      } else if (ret is List) {
        if(!mounted)
          return;
        setState(() {
          _list = ret;
          _controller = TabController(length: _list.length, vsync: this);
        });
      }
    });
  }

  void _handlePageChanged(int index) {
    setState(() {
      _currIndex = index;
    });
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller.dispose();
    }
    super.dispose();
  }

  Widget _getBodyWidget(int index) {
    return _list.isEmpty
        ? Center(
            child: CircularProgressIndicator(),
          )
        : TabBarView(
            physics: PageScrollPhysics(),
            controller: _controller,
            children: _list.map((index) {
              return NewsCategoryListPage(enName: index.enName);
            }).toList(),
          );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: <Widget>[
        (_list.isEmpty)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                color: Theme.of(context).primaryColor,
                child: Row(children: [
                  Expanded(
                      child: TabBar(
                    indicatorColor: Colors.white,
                    isScrollable: true,
                    tabs: _list.map((index) {
                      return Tab(
                        text: index.name,
                      );
                    }).toList(),
                    controller: _controller,
                  )),
                ]),
              ),
        Expanded(
          child: _getBodyWidget(_currIndex),
        ),
      ],
    ));
  }
}
