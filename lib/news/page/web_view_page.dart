import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailPage extends StatefulWidget {
  final String title;
  final String url;

  NewsDetailPage({Key key, this.title, this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetailPage> {
  WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WillPopScope(
          child: WebView(
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted),
          onWillPop: () {
            _goBack();
          }),
    );
  }

  void _goBack() async {
    var canGoBack = await _webViewController.canGoBack();
    if (canGoBack) {
      _webViewController.goBack();
    } else {
      Navigator.of(context).pop();
    }
  }
}
