import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

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

    Future<Response<String>> data = Dio().get("http://gank.io/api/xiandu/categories");
    data.then((Response<String> response){
      return response.data.toString();
    }).then((data){
      setState(() {
        ResponseData response = ResponseData.fromJson(json.decode(data));
        if (!response.error) {
          _list = response.results;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        Category category = _list[index];
        return ListTile(
          title: Text(category.name),
        );
      },
      itemCount: _list.length,
    );
  }
}

class ResponseData {
  final bool error;
  final List<Category> results;

  ResponseData({this.error, this.results});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    return ResponseData(
        error: json['error'],
        results: list.map((i) => Category.fromJson(i)).toList());
  }
}

class Category {
  final String id;
  final String enName;
  final String name;
  final int rank;

  Category({this.id, this.enName, this.name, this.rank});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'],
        enName: json['en_name'],
        name: json['name'],
        rank: json['rank']);
  }
}

/*
{
"error": false,
"results": [
{
"_id": "57c83777421aa97cbd81c74d",
"en_name": "wow",
"name": "科技资讯",
"rank": 1
},
{
"_id": "57c83577421aa97cb162d8b1",
"en_name": "apps",
"name": "趣味软件/游戏",
"rank": 5
}
]
}*/
