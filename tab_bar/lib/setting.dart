import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() =>   _SettingState();
}

class _SettingState extends State<Setting> {
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
                Text('Welcome Setting Screen'),
              ],
            ),
          )
      ),
    );
  }
}