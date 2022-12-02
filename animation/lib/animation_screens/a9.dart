import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';

class AnimationScreenA9 extends StatefulWidget {
  static const routeName = "/AnimationScreenA9";

  const AnimationScreenA9({Key? key}) : super(key: key);

  @override
  _AnimationScreenA9State createState() => _AnimationScreenA9State();
}

class _AnimationScreenA9State extends State<AnimationScreenA9> {
  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute.of(context)!.settings.arguments as Map<String , String>;

    return Scaffold(
      appBar: AppBar(title: Text('${routeArg["title"]}'),),
      body: WidgetWithCodeView(
        child: SomeWidget(),
        sourceFilePath: 'lib/animation_screens/a9.dart',
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

class _SomeWidgetState extends State<SomeWidget> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
      lowerBound: 0.5,
      upperBound: 1,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Scale Transition Animation' ,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold
            ),),
          ScaleTransition(
            scale: _animation,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: FlutterLogo(size: 180,),
            ),
          ),
          Text('Size Transition Animation' ,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold
            ),),
          SizeTransition(
            sizeFactor: _animation,
            axis: Axis.horizontal,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: FlutterLogo(size: 180,),
            ),
          ),
          Text('Fade Transition Animation' ,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold
            ),),
          FadeTransition(
            opacity: _animation,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: FlutterLogo(size: 180,),
            ),
          ),

        ],
      ),
    ),
  );
}
