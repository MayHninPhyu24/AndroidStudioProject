import 'package:flutter/material.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';
import 'dart:math';

import '../components/scaffold_widget.dart';


class Area {
  int index;
  String name;
  Color color;

  Area({this.index:-1,this.name:'Area',this.color:Colors.lightBlueAccent});
}

class MoreFlutterUI2 extends StatefulWidget {
  static const routeName = "/MoreFlutterUI2";

  @override
  _MoreFlutterUI2State createState() => _MoreFlutterUI2State();
}

class _MoreFlutterUI2State extends State<MoreFlutterUI2> {

  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute
        .of(context)!
        .settings
        .arguments as Map<String, String>;
    return Scaffold(
        appBar: AppBar(title: Text('${routeArg["title"]}')),
        body: WidgetWithCodeView(
          child: SomeWidget(),
          sourceFilePath: 'lib/more_flutter_ui_screens/ui2.dart',
          iconBackgroundColor: Colors.white,
          iconForegroundColor: Colors.pink,
          labelBackgroundColor: Theme.of(context).canvasColor,
        ));
    // TODO: implement build
  }
}



class SomeWidget extends StatefulWidget {
  @override
  _SomeWidgetState createState() => new _SomeWidgetState();
}

class _SomeWidgetState extends State<SomeWidget> {
  late int _location;
  late List<Area> _areas;

  @override
  void initState() {
    _areas = <Area>[];
    for(int i=0; i<16; i++) {
      _areas.add(Area(index:i,name:'Area ${i}'));
    }

    var rng = Random();
    _location = rng.nextInt(_areas.length);
  }

  Widget _generate(int index) {
    return GridTile(
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: RaisedButton(
            onPressed: () => _onPressed(index),
            color: _areas[index].color,
            child: new Text(_areas[index].name, textAlign: TextAlign.center),

          ),
        )
    );
  }

  void _onPressed(int index) {
    setState((){
      if(index == _location) {
        _areas[index].color = Colors.green;
        //You won
      } else {
        _areas[index].color = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container (
        padding: EdgeInsets.all(32.0),
        child:Center(
            child: new GridView.count(
              crossAxisCount: 4,
              children: new List<Widget>.generate(16, _generate),
            )
        ),
      ),
    );
  }
}