import 'package:flutter/material.dart';

class ScaffoldDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScaffoldDemoState();
}

class ScaffoldDemoState extends State<ScaffoldDemo>
    with SingleTickerProviderStateMixin {
  int _currIndex = 0;
  TabController _controller;
  List tabs = ["新闻", "人物", "图片"];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
  }

  void _OnTap(int index) {
    setState(() {
      _currIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        title: Text("ScaffoldDemo"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                print("share data");
              }),
        ],
        bottom: TabBar(
          tabs: tabs.map((text) => Tab(text: text)).toList(),
          controller: _controller,
        ),
      ),
      drawer: LeftDrawer(),
      body: TabBarView(
        controller: _controller,
        children: tabs
            .map((text) => Container(
                  alignment: Alignment.center,
                  child: Text(text),
                ))
            .toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(title: Text("Home"), icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              title: Text("Shopcat"), icon: Icon(Icons.add_shopping_cart)),
          BottomNavigationBarItem(title: Text("Me"), icon: Icon(Icons.people)),
        ],
        onTap: _OnTap,
        currentIndex: _currIndex,
      ),

//      bottomNavigationBar: BottomAppBar(
//        color: Colors.white,
//        shape: CircularNotchedRectangle(),
//        child: Row(
//          children: <Widget>[
//            IconButton(icon: Icon(Icons.home), onPressed: () {}),
//            SizedBox(),
//            IconButton(icon: Icon(Icons.business), onPressed: () {}),
//          ],
//          mainAxisAlignment: MainAxisAlignment.spaceAround,
//        ),
//      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("press add button");
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class LeftDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/app_icon.png",
                        width: 40,
                      ),
                    ),
                  ),
                  Text(
                    "Your name",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
                child: ListView(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.add),
                  title: const Text("add account"),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: const Text("Settings"),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
