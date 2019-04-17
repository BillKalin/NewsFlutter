import 'package:flutter/material.dart';

class InheritedWidgetDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InheritedWidgetDemoState();
}

class InheritedWidgetDemoState extends State<InheritedWidgetDemo> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DataInheritedWidget(
        data: count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: TestWidget(),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  count++;
                });
              },
              child: Text("add"),
            ),
          ],
        ),
      ),
    );
  }
}

class DataInheritedWidget extends InheritedWidget {
  DataInheritedWidget({Key key, @required this.data, Widget child})
      : super(key: key, child: child);

  final int data;

  static DataInheritedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(DataInheritedWidget);
  }

  @override
  bool updateShouldNotify(DataInheritedWidget oldWidget) {
    return oldWidget.data != this.data;
  }
}

class TestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TestState();
}

class TestState extends State<TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(DataInheritedWidget.of(context).data.toString());
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    print("TestWidget: didChangeDependencies()");
  }
}
