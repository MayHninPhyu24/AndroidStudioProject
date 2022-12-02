import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() =>   _ContactState();
}

class _ContactState extends State<Contact> {
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar:   AppBar(
        title:   Text('Contact'),
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