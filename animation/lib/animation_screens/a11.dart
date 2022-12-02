import 'dart:math';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';

class AnimationScreenA11 extends StatefulWidget {
  static const routeName = "/AnimationScreenA11";

  const AnimationScreenA11({Key? key}) : super(key: key);

  @override
  _AnimationScreenA11State createState() => _AnimationScreenA11State();
}

class _AnimationScreenA11State extends State<AnimationScreenA11> {
  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute.of(context)!.settings.arguments as Map<String , String>;

    return Scaffold(
      appBar: AppBar(title: Text('${routeArg["title"]}'),),
      body: WidgetWithCodeView(
        child: SomeWidget(),
        sourceFilePath: 'lib/animation_screens/a11.dart',
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
    )..repeat();

    _animation = Tween<Size>(
        begin: Size(200, 150),
        end: Size(200, 350),
    ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.linear));

    _controller.addListener(() => setState(() {

    }));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  double height = 150;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AnimatedBuilder(
            builder: (ctx, child) => FlutterLogo(size: _animation.value.height,),
            animation: _controller,
        ),
        ListTile(
          trailing: Icon(Icons.arrow_forward),
          title: Text('Forward'),
          tileColor: Colors.green,
          onTap: () => _controller.forward(),
        ),
        ListTile(
          leading: Icon(Icons.arrow_back),
          title: Text('Back'),
          tileColor: Colors.red,
          onTap: () => _controller.reverse(),
        ),
      ],

    ),
  );
}
