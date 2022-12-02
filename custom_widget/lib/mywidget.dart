import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32.0),
      child:Column(
        children: <Widget>[
          Text('Custom Stateless Widget'),
          Text('New Year'),
        ],
      )
    );
  }}