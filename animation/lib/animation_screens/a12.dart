import 'dart:math';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';

class AnimationScreenA12 extends StatefulWidget {
  static const routeName = "/AnimationScreenA12";

  const AnimationScreenA12({Key? key}) : super(key: key);

  @override
  _AnimationScreenA12State createState() => _AnimationScreenA12State();
}

class _AnimationScreenA12State extends State<AnimationScreenA12> {
  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute.of(context)!.settings.arguments as Map<String , String>;

    return Scaffold(
      appBar: AppBar(title: Text('${routeArg["title"]}'),),
      body: WidgetWithCodeView(
        child: SomeWidget(),
        sourceFilePath: 'lib/animation_screens/a12.dart',
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
  late Animation<Size> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
      // lowerBound: 0.5,
      // upperBound: 3.0,
    )..repeat();

    _animation = Tween<Size>(
      begin: Size(200, 150),
      end: Size(200, 350),
    ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.linear));

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  double height = 150;
  @override
  Widget build(BuildContext context) => Scaffold(
    body:Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Animated Widget', style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
          Transform.scale(
            scale: 3,
            child: OutlineButtonTransition(width: _controller,),
          ),
          Text('Animated Builder', style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
          Transform.scale(
            scale: 3,
            child: AnimatedBuilder(
              child: OutlineButton(
                onPressed: (){},
                child: const Text('Click Me'),
                borderSide: BorderSide(width: _controller.value),
              ),
              animation: _controller,
              builder: (ctx, child) => Transform.rotate(
                angle: _controller.value * 2 * pi,
                child: child,
              ),
            ),
          )

        ],
      ),
    ),
  );
}

class OutlineButtonTransition extends AnimatedWidget {
  const OutlineButtonTransition({width}):super(listenable: width);

  get width => listenable;

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: (){},
      child: const Text('Click Me'),
      borderSide: BorderSide(width: width.value * 3),
    );
  }
}