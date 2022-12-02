import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';

class AnimationScreenA2 extends StatefulWidget {
  static const routeName = "/AnimationScreenA2";

  const AnimationScreenA2({Key? key}) : super(key: key);

  @override
  _AnimationScreenA2State createState() => _AnimationScreenA2State();
}

class _AnimationScreenA2State extends State<AnimationScreenA2> {
  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute.of(context)!.settings.arguments as Map<String , String>;

    return Scaffold(
      appBar: AppBar(title: Text('${routeArg["title"]}'),),
      body: WidgetWithCodeView(
        child: SomeWidget(),
        sourceFilePath: 'lib/animation_screens/a2.dart',
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
          AnimatedOpacity(
            opacity: visible== true? 1: 0,
            duration: Duration(seconds: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Type: Ow1'),
                Text('Age: 39'),
                Text('Employment: None'),
              ],
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
          // _width = random.nextInt(200).toDouble();
          // _height = random.nextInt(200).toDouble();
          _color = Color.fromRGBO(random.nextInt(256),
              random.nextInt(256),
              random.nextInt(256), 1);
          _borderRadius = BorderRadius.circular(random.nextInt(200).toDouble());
        });
      },
      child: Icon(Icons.flip),
    ),
  );

}
