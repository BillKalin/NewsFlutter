import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class ListViewDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InfiniteListViewState();
}

class ListViewState extends State<ListViewDemo> {
  ScrollController _controller;
  bool showTopBtn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() {
      print("offset = ${_controller.offset}");
      if (_controller.offset < 1000 && showTopBtn) {
        setState(() {
          showTopBtn = false;
        });
      } else if (_controller.offset >= 1000 && !showTopBtn) {
        setState(() {
          showTopBtn = true;
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
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("ListViewDemo"),
      ),
      body:
//        ListView.builder(
//          itemBuilder: (BuildContext context, int index) {
//            return Text(
//              "text = ${index * 2}",
//              style: TextStyle(fontSize: index * 2.toDouble()),
//            );
//          },
//          itemCount: 50,
////          itemExtent: 30,
//        ));
          ListView.separated(
        controller: _controller,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("title = $index"),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.blue,
          );
        },
        itemCount: 50,
      ),
      floatingActionButton: !showTopBtn
          ? null
          : FloatingActionButton(
              onPressed: () {
                _controller.animateTo(.0,
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
              },
              child: Icon(Icons.arrow_upward),
            ),
    );
  }
}

class InfiniteListViewState extends State<ListViewDemo> {
  static const loadingTag = "##loading##"; //表尾标记

  List<String> _words = [loadingTag];
  String progress = "0%";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchMoreData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("InfiniteListViewState"),
      ),
      body: NotificationListener(
        onNotification: (ScrollNotification notification) {
          double progress = notification.metrics.pixels /
              notification.metrics.maxScrollExtent;
          setState(() {
            this.progress = "${(progress * 100).toInt()}%";
          });
          return true;
        },
        child: Stack(
          children: [
            Column(children: [
              ListTile(
                title: Text("English word"),
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    if (_words[index] == loadingTag) {
                      if (_words.length < 100) {
                        //load more data
                        _fetchMoreData();

                        return Container(
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 3.0,
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.center,
                          child: Text(
                            "没有更多了",
                            style: TextStyle(color: Colors.grey),
                          ),
                        );
                      }
                    } else {}

                    return ListTile(
                      title: Text(_words[index]),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: .0,
                    );
                  },
                  itemCount: _words.length,
                ),
              ),
            ]),
            Container(
              alignment: Alignment.center,
              child: CircleAvatar(
                //显示进度百分比
                radius: 30.0,
                child: Text(progress),
                backgroundColor: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchMoreData() {
    Future.delayed(Duration(seconds: 2)).then((newValue) {
      _words.insertAll(_words.length - 1,
          generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      setState(() {});
    });
  }
}
