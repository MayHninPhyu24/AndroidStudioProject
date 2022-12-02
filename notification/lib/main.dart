import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(new MaterialApp(
    home:new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

enum Answers{YES,NO,MAYBE}
class _State extends State<MyApp> {
  final GlobalKey<ScaffoldState> _scaffoldstate = GlobalKey<ScaffoldState>();
  String _value = '';

  void _showBar() {
    _scaffoldstate.currentState!.showSnackBar(new SnackBar(content: Text("Hello! How Are You?")));
  }
  Future _showAlert(BuildContext context, String message) async {
    return showDialog(
      context: context,
      builder:  (_) => new AlertDialog(
        title: new Text(message),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.pop(context),
            child: new Text('Ok'),
          ),
        ],
      ),
    );
  }

  void _showButton(){
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Some Info Here',
                  style: TextStyle(color: Colors.red,fontWeight:FontWeight.bold),),
                RaisedButton(onPressed: ()=>Navigator.pop(context),child:Text('Close'),)
              ],
            )
          );
        }
    );
  }
  void _setValue(String value) => setState(() => _value = value);

  Future _askUser() async {
    switch(
      await showDialog(
        context: context,
          builder: (BuildContext context) {
            return new SimpleDialog(
              title: new Text('Do you like Flutter?'),
              children: <Widget>[
                new SimpleDialogOption(child: new Text('Yes!!!'),onPressed: (){Navigator.pop(context, Answers.YES);},),
                new SimpleDialogOption(child: new Text('NO :('),onPressed: (){Navigator.pop(context, Answers.NO);},),
                new SimpleDialogOption(child: new Text('Maybe :|'),onPressed: (){Navigator.pop(context, Answers.MAYBE);},),
              ],
            );
          }
      )
    ) {
      case Answers.YES:
        _setValue('Yes');
        break;
      case Answers.NO:
        _setValue('No');
        break;
      case Answers.MAYBE:
        _setValue('Maybe');
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key:_scaffoldstate,
      appBar: AppBar(
        title: Text('Name Here'),
      ),
    body: Container (
        padding: EdgeInsets.all(32.0),
        child:Center(
            child: Column(
                children: <Widget>[
                  Text(_value),
                  RaisedButton(onPressed: _showButton,child:Text('Show Button'),),
                  RaisedButton(onPressed: _showBar, child: new Text('Show Bar'),),
                  RaisedButton(onPressed: () => _showAlert(context, 'Do you like flutter, I do!'), child: new Text('Show Dialog'),),
                  RaisedButton(onPressed: _askUser, child: new Text('Show Simple Dialog'),),
                ],
            ),
        ),
    ),
    );
  }
}