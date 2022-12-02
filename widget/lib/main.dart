import 'package:flutter/material.dart';

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
        title: Text('Name Here'),
      ),
    body: Container (
        padding: EdgeInsets.all(32.0),
        child:Center(
            child: Column(
                children: <Widget>[
                  Text('Hello World')
                ],
            ),
        ),
    ),
    );

  }
}