import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';

class JsonDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => JsonState();
}

class JsonState extends State<JsonDemo> {

  @override
  void initState() {
    super.initState();
    User user = new User("billkalin", "bjxiongjialin@gmail.com");
    Map<String, dynamic> map = user.toJson();
    print(map);
    User user2 = User.fromJson(map);
    print("user name = ${user2.name}, email = ${user2.email}");
    print("serialize user ${json.encode(user)}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Json Demo"),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Text("json demo"),
        ),
      ),
    );
  }
}

class User {
  final String name;
  final String email;

  User(this.name, this.email);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'name': name, 'email': email};
  }
}
