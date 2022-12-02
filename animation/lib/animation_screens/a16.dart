import 'dart:math';
import 'package:animation/animation_screens/a16_another.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';

class AnimationScreenA16 extends StatefulWidget {
  static const routeName = "/AnimationScreenA16";

  const AnimationScreenA16({Key? key}) : super(key: key);

  @override
  _AnimationScreenA16State createState() => _AnimationScreenA16State();
}

class _AnimationScreenA16State extends State<AnimationScreenA16> {
  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute.of(context)!.settings.arguments as Map<String , String>;

    return Scaffold(
      appBar: AppBar(title: Text('${routeArg["title"]}'),),
      body: WidgetWithCodeView(
        child: SomeWidget(),
        sourceFilePath: 'lib/animation_screens/a16.dart',
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        children: [
          RaisedButton.icon(
              onPressed: ()=> Navigator.push(context, PageTransition(
                  type: PageTransitionType.fade,
                  child: A16Another())),
              icon: Icon(Icons.arrow_forward_ios),
              label: Text('Fade Another Page')),
          RaisedButton.icon(
              onPressed: ()=> Navigator.push(context, PageTransition(
                  type: PageTransitionType.leftToRight,
                  child: A16Another())),
              icon: Icon(Icons.arrow_forward_ios),
              label: Text('Left To Right Another Page')),
          RaisedButton.icon(
              onPressed: ()=> Navigator.push(context, PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: A16Another())),
              icon: Icon(Icons.arrow_forward_ios),
              label: Text('Right To Left Another Page')),
          RaisedButton.icon(
              onPressed: ()=> Navigator.push(context, PageTransition(
                  type: PageTransitionType.topToBottom,
                  child: A16Another())),
              icon: Icon(Icons.arrow_forward_ios),
              label: Text('Top To Bottom Another Page')),
          RaisedButton.icon(
              onPressed: ()=> Navigator.push(context, PageTransition(
                  type: PageTransitionType.bottomToTop,
                  child: A16Another())),
              icon: Icon(Icons.arrow_forward_ios),
              label: Text('Bottom To Top Another Page')),
          RaisedButton.icon(
              onPressed: ()=> Navigator.push(context, PageTransition(
                  type: PageTransitionType.scale,
                  alignment: Alignment.bottomCenter,
                  child: A16Another())),
              icon: Icon(Icons.arrow_forward_ios),
              label: Text('scale Another Page')),
          RaisedButton.icon(
              onPressed: ()=> Navigator.push(context, PageTransition(
                  type: PageTransitionType.size,
                  alignment: Alignment.bottomCenter,
                  child: A16Another())),
              icon: Icon(Icons.arrow_forward_ios),
              label: Text('size Another Page')),
          RaisedButton.icon(
              onPressed: ()=> Navigator.push(context, PageTransition(
                  type: PageTransitionType.rotate,
                  alignment: Alignment.bottomCenter,
                  duration: Duration(seconds: 1),
                  child: A16Another())),
              icon: Icon(Icons.arrow_forward_ios),
              label: Text('rotate Another Page')),
          RaisedButton.icon(
              onPressed: ()=> Navigator.push(context, PageTransition(
                  type: PageTransitionType.rightToLeftWithFade,
                  child: A16Another())),
              icon: Icon(Icons.arrow_forward_ios),
              label: Text('right To Left With Fade Another Page')),
          RaisedButton.icon(
              onPressed: ()=> Navigator.push(context, PageTransition(
                  type: PageTransitionType.leftToRightWithFade,
                  child: A16Another())),
              icon: Icon(Icons.arrow_forward_ios),
              label: Text('Left To Right With Fade Another Page')),
        ],
      ),
    ),
  );
}

