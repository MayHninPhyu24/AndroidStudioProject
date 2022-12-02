import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Column(
        children: <Widget>[
          Text('Click to navigate'),
          RaisedButton(onPressed: (){Navigator.of(context).pushNamed('/Home');},child: Text('Click Me'),),
        ],
      )
    );
  }
}