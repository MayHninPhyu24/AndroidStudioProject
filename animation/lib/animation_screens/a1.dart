import 'dart:math';

import 'package:animation/components/scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';

class AnimationScreenA1 extends StatefulWidget {
  static const routeName = "/AnimationScreenA1";

  const AnimationScreenA1({Key? key}) : super(key: key);

  @override
  _AnimationScreenA1State createState() => _AnimationScreenA1State();
}

class _AnimationScreenA1State extends State<AnimationScreenA1> {
  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute.of(context)!.settings.arguments as Map<String , String>;
    return scaffoldWidget(context, SomeWidget(), routeArg["title"], 'lib/animation_screens/a1.dart');
  }
}

class SomeWidget extends StatefulWidget {

  @override
  State<SomeWidget> createState() => _SomeWidgetState();
}

class _SomeWidgetState extends State<SomeWidget> {
  double _width = 50;
  double _height = 50;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);
  bool visible = true;
  @override
  Widget build(BuildContext context) =>Scaffold(
    body:  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            curve: Curves.linear,
            duration: Duration(seconds: 1),
            width: _width, height: _height,
            decoration: BoxDecoration(
              color: _color, borderRadius: _borderRadius,
            ),
          ),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: (){
        setState(() {
          Random random = Random();
          visible = !visible;
          _width = random.nextInt(200).toDouble();
          _height = random.nextInt(200).toDouble();
          _color = Color.fromRGBO(random.nextInt(256),
              random.nextInt(256), random.nextInt(256), 1);
          _borderRadius = BorderRadius.circular(random.nextInt(200).toDouble());
        });
      },
      child: Icon(Icons.flip),
    ),
  );
}
