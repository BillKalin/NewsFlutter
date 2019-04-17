import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class Network extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NetworkState();
}

class NetworkState extends State<Network> {
  String _data = "";

  Future<String> request() async {
    HttpClient client = HttpClient();
    HttpClientRequest request =
        await client.getUrl(Uri.parse("https://www.baidu.com"));
    request.headers.add("user-agent",
        "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1");
    HttpClientResponse response = await request.close();
    client.close();
    return response.transform(utf8.decoder).join();
  }

  void request2() {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    useDio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Network Request"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                HttpClient()
                    .getUrl(Uri.parse("https://www.baidu.com"))
                    .then((HttpClientRequest req) {
                  req.headers.add("user-agent",
                      "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1");
                  return req.close();
                }).then((HttpClientResponse response) {
                  return response.transform(utf8.decoder).join();
                }).then((String content) {
                  setState(() {
                    _data = content;
                  });
                }).whenComplete(() {});

//                request().then((value) {
//                  setState(() {
//                    _data = value;
//                  });
//                });
              },
              child: Text("Request"),
            ),
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(_data),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<Null> useDio() async {
    Dio dio = new Dio();
    Response<String> response = await dio.get("http://www.baidu.com");
    String content = response.data.toString();
    print("useDio : content = $content");
  }
}
