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
    _controller.dispose();
    super.dispose();
  }

  Widget _getBodyWidget(int index) {
    if (index == 0) {
      return Container(
        alignment: Alignment.center,
        child: Text("Home"),
      );
    } else if (index == 1) {
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
    } else if (index == 2) {
      return Container(
        alignment: Alignment.center,
        child: Text("Me"),
      );
    }
    return Container(
      alignment: Alignment.center,
      child: Text("Me"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("今日干货"),
        bottom: (_list.isEmpty || _currIndex != 1)
            ? null
            : TabBar(
                isScrollable: true,
                tabs: _list.map((index) {
                  return Tab(
                    text: index.name,
                  );
                }).toList(),
                controller: _controller,
              ),
      ),
      body: Container(
        child: _getBodyWidget(_currIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("HOME")),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), title: Text("CATEGORY")),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("ME")),
        ],
        currentIndex: _currIndex,
        onTap: _handlePageChanged,
      ),
    );
  }
}
