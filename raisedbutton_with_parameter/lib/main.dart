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
  String _value = "Hello World";
  int _num = 0;
  void _onPressed() {
    setState((){
      _value = new DateTime.now().toString();
    });
  }

  void _add() {
    setState((){
      _num++;
    });
  }

  void _subtract(){
    setState(() {
      _num--;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Name Here'),
      ),
    body: Container (
        padding: EdgeInsets.all(32.0),
        child: new Center(
            child: Column(
              children: <Widget>[
                Text(_value),
                new RaisedButton(onPressed: _onPressed,child:new Text('Click Me'),),
                new FlatButton(onPressed:_onPressed,child:new Text('Click Me'),),
                new Text('Value= ${_num}'),
                new IconButton(icon: new Icon(Icons.add),onPressed: _add),
                new IconButton(icon: new Icon(Icons.remove), onPressed: _subtract),
              ],
            ) ,
        ),
    ),
    );
  }
}