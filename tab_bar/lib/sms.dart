import 'package:flutter/material.dart';

class SMS extends StatefulWidget {
  @override
  _SMSState createState() =>   _SMSState();
}

class _SMSState extends State<SMS> {
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar:   AppBar(
        title:   Text('SMS'),
      ),
      body:   Container(
          padding:   EdgeInsets.all(32.0),
          child:   Center(
            child:   Column(
              children: <Widget>[
                Text('Welcome Contact'),
              ],
            ),
          )
      ),
    );
  }
}