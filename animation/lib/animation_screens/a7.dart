import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';

class AnimationScreenA7 extends StatefulWidget {
  static const routeName = "/AnimationScreenA7";

  const AnimationScreenA7({Key? key}) : super(key: key);

  @override
  _AnimationScreenA7State createState() => _AnimationScreenA7State();
}

class _AnimationScreenA7State extends State<AnimationScreenA7> {
  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute.of(context)!.settings.arguments as Map<String , String>;

    return Scaffold(
      appBar: AppBar(title: Text('${routeArg["title"]}'),),
      body: WidgetWithCodeView(
        child: SomeWidget(),
        sourceFilePath: 'lib/animation_screens/a7.dart',
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
 double _value = 0;
 double _angle = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TweenAnimationBuilder<double>(
              tween: Tween(
                begin: 0,
                end: _angle
              ),
              duration: Duration(seconds: 1),
              builder: (_, double value, child) =>  Transform.rotate(
                angle: value,
                child: Container(
                  height: 200,
                  width: 300,
                  color: Colors.green,
                ),
              ),
              child:  Container(
                height: 200,
                width: 300,
                color: Colors.green,
              ),
          ),
          Text("${(_value * (180/ pi)).round()}",
            style: TextStyle(fontSize: 30)),
          Slider(
              value: _value,
              onChanged: (val) => setState(() {
                _value = val;
                _angle = val;
              }),
              min: 0,
              max: pi * 2,
              divisions: 4,
          )
        ]
      ),
    ),
  );
}
