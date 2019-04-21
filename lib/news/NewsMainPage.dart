import 'package:flutter/material.dart';
import 'package:news_fluttter/news/NewsCategoryListPage.dart';
import 'package:news_fluttter/news/constants/Api.dart';
import 'package:news_fluttter/news/model/BaseReponse.dart';
import 'package:news_fluttter/news/model/Category.dart';
import 'package:news_fluttter/news/network/NetUtils.dart';

class NewsMainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewMainState();
}

class _NewMainState extends State<NewsMainPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  List<Category> _list = [];

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
        setState(() {
          _list = ret;
          _controller = TabController(length: _list.length, vsync: this);
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("今日干货"),
        bottom: _list.isEmpty
            ? null
            : TabBar(
                isScrollable: true,
                tabs: _list.map((index) {
                  return Text(
                    index.name,
                    style: TextStyle(fontSize: 18),
                  );
                }).toList(),
                controller: _controller,
              ),
      ),
      body: _list.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : TabBarView(
              controller: _controller,
              children: _list.map((index) {
                return NewsCategoryListPage(enName: index.enName);
              }).toList(),
            ),
    );
  }
}
