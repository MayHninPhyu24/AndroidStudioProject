import 'package:flutter/material.dart';

class Mail extends StatefulWidget {
  @override
  _MailState createState() =>   _MailState();
}

class _MailState extends State<Mail> {
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar:   AppBar(
        title:   Text('Mail'),
      ),
      body:   Container(
          padding:   EdgeInsets.all(32.0),
          child:   Center(
            child:   Column(
              children: <Widget>[
                Text('Welcome Mail Screen'),
              ],
            ),
          )
      ),
    );
  }
}