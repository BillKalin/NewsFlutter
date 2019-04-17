import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/services.dart';

class RandomWordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RandomWordState();
  }
}

class RandomWordState extends State<RandomWordPage> {
  String text = "";

  void changeRandomWord() {
    WordPair t = WordPair.random();
    loadAssetString().then((data) {
      setState(() {
        text = data;
      });
    });
//    setState(() {
//      text = t.toString();
//    });
  }

  Future<String> loadAssetString() async {
    return await rootBundle.loadString("assets/app_icon.json");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Randowm Words")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(text),
            new Image.asset("assets/app_icon.png"),
          ],
        ),
      ),
      bottomSheet: MaterialButton(
          onPressed: () {
            changeRandomWord();
          },
          child: Text("add")),
    );
  }
}
