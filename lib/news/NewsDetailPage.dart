import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class NewsDetailPage extends StatefulWidget {
  final String title;
  final String url;

  NewsDetailPage({Key key, this.title, this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      url: widget.url,
      initialChild: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
