import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';

class AnimationScreenA10 extends StatefulWidget {
  static const routeName = "/AnimationScreenA10";

  const AnimationScreenA10({Key? key}) : super(key: key);

  @override
  _AnimationScreenA10State createState() => _AnimationScreenA10State();
}

class _AnimationScreenA10State extends State<AnimationScreenA10> {
  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute.of(context)!.settings.arguments as Map<String , String>;

    return Scaffold(
      appBar: AppBar(title: Text('${routeArg["title"]}'),),
      body: WidgetWithCodeView(
        child: SomeWidget(),
        sourceFilePath: 'lib/animation_screens/a10.dart',
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
  late Animation<AlignmentGeometry> _animation;
  late Animation<Offset> _slideAnimation;
  final DecorationTween  _decoration = DecorationTween(
      begin: BoxDecoration(color: Colors.red),
      end: BoxDecoration(color: Colors.green),
  );
  late Animation<TextStyle> _textAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<AlignmentGeometry>(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft).animate(
        CurvedAnimation(parent: _controller, curve: Curves.linear)
    );

    _slideAnimation = Tween<Offset>(
        begin: Offset(0,0),
        end: Offset(1,1)).animate(CurvedAnimation(
        curve: Curves.linear,
        parent: _controller,
    ));

    _textAnimation = TextStyleTween(
      begin: TextStyle(color:  Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
      end: TextStyle(color: Colors.blue,
        fontWeight: FontWeight.bold,
        fontSize: 45,
      ),
    ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.linear));

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Align Transition Animation' ,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold
              ),),
            AlignTransition(
              alignment : _animation,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: FlutterLogo(size: 180,),
              ),
            ),
            SizedBox(height: 30,),
            const Text('Slide Transition Animation' ,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold
              ),),
            SlideTransition(
              position : _slideAnimation,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: FlutterLogo(size: 180,),
              ),
            ),
            SizedBox(height: 30,),
            const Text('Decoration Transition Animation' ,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold
              ),),
            DecoratedBoxTransition(
              decoration : _decoration.animate(_controller),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: FlutterLogo(size: 180,),
              ),
            ),
            SizedBox(height: 30,),
            const Text('Text Style Transition Animation' ,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold
              ),),
            DefaultTextStyleTransition(
              style : _textAnimation,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Hello World!"),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
