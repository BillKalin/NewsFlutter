import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FileState();
}

class FileState extends State<FileDemo> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    getCounter().then((int value) {
      setState(() {
        _counter = value;
      });
    });
  }

  Future<File> getLocalFile() async {
    var file = await getTemporaryDirectory();
    print("temp file path = ${file.path}");
    return File("${file.path}/count.txt");
  }

  Future<int> getCounter() async {
    try {
      File file = await getLocalFile();
      String content = await file.readAsString();
      return int.parse(content);
    } on FileSystemException {
      return 0;
    }
  }

  Future<Null> addCounter() async {
    setState(() {
      _counter++;
    });

    (await getLocalFile()).writeAsStringSync("$_counter");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Demo"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[Text("click times : $_counter")],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addCounter();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
