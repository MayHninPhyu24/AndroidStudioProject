import 'package:flutter/material.dart';
import '../mywidget.dart';
import '../code/GlobalState.dart';

class Fourth extends StatefulWidget {
  Fourth(this.name);
  String name;
  @override
  _FourthState createState() => new _FourthState(name);
}

class _FourthState extends State<Fourth> {
  _FourthState(this.name);

  String name;

  GlobalState _store = GlobalState.instance;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Name here'),
      ),
      body: new Container(
          padding: new EdgeInsets.all(32.0),
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Text('Fourth Page'),
                Text('Hello ${_store.get('name')}'),
                RaisedButton(onPressed: (){Navigator.of(context).pop();},child: Text('Back'),),
              ],
            ),
          )
      ),
    );
  }
}