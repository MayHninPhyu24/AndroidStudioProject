import 'package:flutter/material.dart';
import '../code/GlobalState.dart';
import './fourth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _name = TextEditingController();
  GlobalState _store = GlobalState.instance;

  @override
  void initState() {
    _store.set('name', '');
    _name.text = _store.get('name');
  }

  void _onPressed() {
    setState((){
      _store.set('name',_name.text);
    });
    Navigator.push(context, new MaterialPageRoute(
        builder: (BuildContext context) => new Fourth(_name.text)
    ));
   // Navigator.of(context).pushNamed('/Fourth');
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Name here'),
      ),
      body: new Container(
          padding: new EdgeInsets.all(32.0),
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Text('Welcome Home'),
                new RaisedButton(onPressed: (){Navigator.of(context).pushNamedAndRemoveUntil('/Second', (Route<dynamic> route) => false);},
                  child: new Text('Next'),),
                new RaisedButton(onPressed: (){Navigator.of(context).pushNamedAndRemoveUntil('/Second', (Route<dynamic> route) => false);}, child: new Text('Next'),),

                TextField(
                  controller: _name,
                  decoration: InputDecoration(labelText: 'Enter Your Name'),
                ),
                RaisedButton(onPressed:_onPressed, child: Text('Next'),),
              ],
            ),
          )
      ),
    );
  }
}