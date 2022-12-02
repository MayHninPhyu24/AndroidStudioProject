import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';

class AnimationScreenA4 extends StatefulWidget {
  static const routeName = "/AnimationScreenA4";

  const AnimationScreenA4({Key? key}) : super(key: key);

  @override
  _AnimationScreenA4State createState() => _AnimationScreenA4State();
}

class _AnimationScreenA4State extends State<AnimationScreenA4> {
  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute.of(context)!.settings.arguments as Map<String , String>;

    return Scaffold(
      appBar: AppBar(title: Text('${routeArg["title"]}'),),
      body: WidgetWithCodeView(
        child: SomeWidget(),
        sourceFilePath: 'lib/animation_screens/a4.dart',
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
  double padValue = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: AnimatedPadding(
        duration: Duration(milliseconds: 500),
        padding: EdgeInsets.symmetric(horizontal: padValue),
        child: Container(
          color: Colors.blue,
          height: 200,
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: (){
        setState(() {
          padValue = padValue == 0 ? 25 :0;
        });
      },
      child: Icon(Icons.play_arrow),
    ),
  );
}
