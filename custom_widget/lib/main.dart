import 'package:flutter/material.dart';
import 'mywidget.dart';
import 'clock.dart';
import 'timecounter.dart';

void main() {
  runApp(new MaterialApp(
    home:new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Widget'),
      ),
    body: Container (
        padding: EdgeInsets.all(32.0),
        child:Center(
            child: Column(
                children: <Widget>[
                  Text('Hello Main'),
                  MyWidget(),
                  Text('Custom Stateful Widget'),
                  Clock(),
                  new Text('My Stop Watch'),
                  new TimeCounter()
                ],
            ),
        ),
    ),
    );
  }
}