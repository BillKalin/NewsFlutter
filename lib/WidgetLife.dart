import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class WidgetLife extends StatefulWidget {
  WidgetLife({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return WidgetLifeState();
  }
}

class WidgetLifeState extends State<WidgetLife> {
  TapGestureRecognizer mTap;
  bool _switchValue = false;
  bool _boxValue = false;
  TextEditingController mController;

  @override
  void initState() {
    super.initState();
    print("initState()");
    mTap = new TapGestureRecognizer()..onTap = handleTap;
    mController = new TextEditingController();
    mController.addListener(() {
      print("addListener: " + mController.text);
    });
  }

  void handleTap() {
    print("handle tap () ");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies()");
  }

  @override
  void didUpdateWidget(WidgetLife oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget()");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble()");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose()");
  }

  @override
  Widget build(BuildContext context) {
    print("build()");
    return Scaffold(
      appBar: AppBar(
        title: Text("Widget Demo"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.title,
              style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'Courier',
                  fontSize: 18,
                  height: 1.5,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white),
            ),
            Text("Hello Dart!!", textAlign: TextAlign.center),
            Text(
              "Hello Dart!!" * 10,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              "Hello Dart",
              textScaleFactor: 1.5,
            ),
            Text.rich(TextSpan(children: [
              TextSpan(text: 'Home:'),
              TextSpan(text: 'https://flutterchina.club', recognizer: mTap)
            ])),
            RaisedButton(
              onPressed: () => {},
              child: Text(
                "RaisedButton",
                style: TextStyle(color: Colors.white),
              ),
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.blue,
            ),
            Row(
              children: <Widget>[
                FlatButton(
                  onPressed: () => {},
                  child: Text(
                    "FlatButton",
                    style: TextStyle(color: Colors.white),
                  ),
                  highlightColor: Colors.blue[700],
                  colorBrightness: Brightness.dark,
                  splashColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.blue,
                ),
                OutlineButton(
                  onPressed: () => {},
                  child: Text("OutlineButton"),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Image.asset(
                  "assets/app_icon.png",
                  fit: BoxFit.fill,
                  width: 100,
                  height: 100,
                ),
                Image.network(
                  "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",
                  width: 100,
                  height: 100,
                ),
                Switch(
                  value: _switchValue,
                  onChanged: (newValue) {
                    setState(() {
                      _switchValue = newValue;
                    });
                  },
                ),
                Checkbox(
                    value: _boxValue,
                    onChanged: (newValue) {
                      setState(() {
                        _boxValue = newValue;
                      });
                    }),
              ],
            ),
            TextField(
              controller: mController,
              decoration: InputDecoration(
                icon: Icon(Icons.people),
                labelText: "UserName:",
                hintText: "please input user name.",
              ),
//                  errorText: "user name can't be empty!"),
              onSubmitted: (text) {
                print("submit username = $text");
              },
            ),
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: "Password:",
                hintText: "please input password.",
              ),
//                  errorText: "passworde can't be empty!"),
              onSubmitted: (text) {
                print("submit password = $text");
              },
              obscureText: true,
            )
          ],
        ),
      ),
    );
  }
}
