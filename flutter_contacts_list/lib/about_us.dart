import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() =>   _AboutState();
}

class _AboutState extends State<About> {
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar:   AppBar(
        title:   Text('Setting'),
      ),
      body:   Container(
          padding:   EdgeInsets.all(32.0),
          child:   Center(
            child:   Column(
              children: <Widget>[
                Text('Welcome About Us Screen'),
              ],
            ),
          )
      ),
    );
  }
}