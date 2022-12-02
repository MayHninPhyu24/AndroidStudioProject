import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';

class AnimationScreenA3 extends StatefulWidget {
  static const routeName = "/AnimationScreenA3";

  const AnimationScreenA3({Key? key}) : super(key: key);

  @override
  _AnimationScreenA3State createState() => _AnimationScreenA3State();
}

class _AnimationScreenA3State extends State<AnimationScreenA3> {
  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute.of(context)!.settings.arguments as Map<String , String>;

    return Scaffold(
      appBar: AppBar(title: Text('${routeArg["title"]}'),),
      body: WidgetWithCodeView(
        child: SomeWidget(),
        sourceFilePath: 'lib/animation_screens/a3.dart',
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
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);
  bool visible = true;
  @override
  Widget build(BuildContext context) => Scaffold(
    body:Stack(
      children: [
        Container(
          width: double.infinity, height: double.infinity, color: Colors.black12,
        ),
        const Center(
          child:  Text('My text',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(seconds: 2),
          bottom: visible == true?250:350,
          right: 100,
          child: Container(
            width: 200,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: _borderRadius,
              color: _color,
            ),
          ),
        )
      ],
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: (){
        setState(() {
          Random random = Random();
          visible = !visible;
          //_width = random.nextInt(200).toDouble();
          //_height = random.nextInt(200).toDouble();
          _color = Color.fromRGBO(random.nextInt(256),
              random.nextInt(256),
              random.nextInt(256), 1);
          _borderRadius = BorderRadius.circular(random.nextInt(200).toDouble());
        });
      },
      child: Icon(Icons.play_arrow),
    ),
  );
}
