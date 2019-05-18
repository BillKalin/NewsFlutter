import 'package:flutter/material.dart';
import 'package:news_fluttter/news/page/news_home_page.dart';
import 'package:news_fluttter/news/page/news_main_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const List<BottomNavigationBarItem> _bottomList = [
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
    BottomNavigationBarItem(
        icon: Icon(Icons.category), title: Text("Category")),
    BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("Me")),
  ];

  static final List<Widget> _pageList = [
    NewsHomePage(),
    NewsMainPage(),
    Container(
      alignment: Alignment.center,
      child: Text("Me"),
    ),
  ];

  int _currIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleBottomItemClick(int index) {
    setState(() {
      _currIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: _pageList,
        index: _currIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomList,
        currentIndex: _currIndex,
        onTap: _handleBottomItemClick,
      ),
    );
  }
}
