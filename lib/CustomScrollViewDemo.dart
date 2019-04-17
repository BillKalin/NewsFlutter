import 'package:flutter/material.dart';

class CustomScrollViewDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CustomScrollViewState();
}

class CustomScrollViewState extends State<CustomScrollViewDemo> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child:
//      Scaffold(
//      appBar: AppBar(
//        title: Text("CustomScrollview"),
//      ),
//      body:
          CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Header"),
              background: Container(
                color: Colors.blue,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  //创建子widget
                  return new Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: new Text('grid item $index'),
                  );
                }, childCount: 20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0,
                )),
          ),
          SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  //创建列表项
                  return new Container(
                    alignment: Alignment.center,
                    color: Colors.lightBlue[100 * (index % 9)],
                    child: new Text('list item $index'),
                  );
                },
                childCount: 50,
              ),
              itemExtent: 50),
        ],
      ),
    );
  }
}
