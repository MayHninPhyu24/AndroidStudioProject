import 'package:flutter/material.dart';

class Contact extends StatefulWidget{
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact>{
  String name="Phyu";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stateful Widget',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Stateful Widget'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value){
                setState(() {
                  print(value);
                  name = value;
                });
              },
            ),
            Text("Hello $name"),
          ],
        ),
      ),
    );
  }
}