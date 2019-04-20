
import 'package:flutter/material.dart';
import 'package:news_fluttter/news/model/BaseReponse.dart';
import 'package:news_fluttter/news/model/Category.dart';
import 'package:news_fluttter/news/model/SubCategory.dart';
import 'package:news_fluttter/news/network/NetUtils.dart';

class NewsMainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewsMainPageState();
}

class NewsMainPageState extends State<NewsMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("今日干货"),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: NewsPageList(),
      ),
    );
  }
}

class NewsPageList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewsPageListState();
}

class NewsPageListState extends State<NewsPageList> {
  List<Category> _list = List();

  @override
  void initState() {
    Future data = NetUtils.get("http://gank.io/api/xiandu/categories");
    data.then((dynamic response) {
//      var error = response['error'];
//      var results = response['results'];
      var baseResponse = BaseResponse.fromJson(response);
      return Category.parseJson(baseResponse.results);
    }).then((data) {
      setState(() {
        _list = data;
      });
    });
    super.initState();
  }

  void _getSubCategory(String enName) {
    Future subRes = NetUtils.get("http://gank.io/api/xiandu/category/$enName");
    subRes.then((dynamic source) {
      var baseResponse = BaseResponse.fromJson(source);
      return SubCategory.parseJson(baseResponse.results);
    }).then((data) {
      print("data = $data");
    });
  }

  @override
  Widget build(BuildContext context) {
    return _list.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              Category category = _list[index];
              return ListTile(
                title: Text(category.name),
                onTap: () {
                  _getSubCategory(category.enName);
                },
              );
            },
            itemCount: _list.length,
          );
  }
}
