import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';

class AnimationScreenA6 extends StatefulWidget {
  static const routeName = "/AnimationScreenA6";

  const AnimationScreenA6({Key? key}) : super(key: key);

  @override
  _AnimationScreenA6State createState() => _AnimationScreenA6State();
}

class _AnimationScreenA6State extends State<AnimationScreenA6> {
  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute.of(context)!.settings.arguments as Map<String , String>;

    return Scaffold(
      appBar: AppBar(title: Text('${routeArg["title"]}'),),
      body: WidgetWithCodeView(
        child: SomeWidget(),
        sourceFilePath: 'lib/animation_screens/a6.dart',
        iconBackgroundColor: Colors.white,
        iconForegroundColor: Colors.pink,
        labelBackgroundColor: Theme.of(context).canvasColor,
      ),
    );
  }
}

class SomeWidget extends StatefulWidget {

  @override
  State<SomeWidget> createState() => _SomeWidgetState();
}

class _SomeWidgetState extends State<SomeWidget> {
  double _fontSize =40;
  Color _color = Colors.red;
  FontWeight _fontWeight = FontWeight.bold;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: AnimatedDefaultTextStyle(
        duration: Duration(milliseconds: 500),
        style:TextStyle(
          color: _color, fontWeight: _fontWeight, fontSize: _fontSize),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            Text('My Text'),
            Text('My Text')
          ]
        ),
      )
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: (){
        Random _random = Random();
        setState(() {
          _fontSize = _random.nextInt(60).toDouble();
          _color = Color.fromRGBO(_random.nextInt(256),
            _random.nextInt(256), _random.nextInt(256), 1
          );
          //_fontWeight = FontWeight.w400;
        });
      },
      child: Icon(Icons.play_arrow),
    ),
  );
}
