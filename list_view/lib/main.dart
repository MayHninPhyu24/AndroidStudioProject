import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

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
  Map _countries = new Map();

  void _getData() async{
    var response = await http.get(Uri.parse("http://country.io/names.json"));

    if(response.statusCode == 200) {
      setState(()=> _countries = json.decode(response.body));
      print("Loaded ${_countries.length} Countries");
    }else{
      print("Status Code: ${response.statusCode}");
    }
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
        child:Center(
            child: Column(
                children: <Widget>[
                  Text('Countries',style:TextStyle(fontWeight:FontWeight.bold)),
                  Expanded(child:ListView.builder(
                    itemCount: _countries.length,
                    itemBuilder:  (BuildContext context, int index) {
                      String key = _countries.keys.elementAt(index);
                      return Row(
                        children: <Widget> [
                          Text('${key}'),
                          Text(_countries[key]),
                        ],
                      );
                    }
                  ))
                ],
            ),
        ),
    ),
    );
  }

  @override
  void initState() {
    _getData();
  }
}