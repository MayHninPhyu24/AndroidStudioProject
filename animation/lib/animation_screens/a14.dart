import 'dart:math';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';

class AnimationScreenA14 extends StatefulWidget {
  static const routeName = "/AnimationScreenA14";

  const AnimationScreenA14({Key? key}) : super(key: key);

  @override
  _AnimationScreenA14State createState() => _AnimationScreenA14State();
}

class _AnimationScreenA14State extends State<AnimationScreenA14> {
  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute.of(context)!.settings.arguments as Map<String , String>;

    return Scaffold(
      appBar: AppBar(title: Text('${routeArg["title"]}'),),
      body: WidgetWithCodeView(
        child: SomeWidget(),
        sourceFilePath: 'lib/animation_screens/a14.dart',
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
      child: Builder(
        builder: (ctx) => FlatButton(
            onPressed: ()=> Navigator.push(
                ctx,
                MaterialPageRoute(
                  builder: (_) => FlutterPage())),
            child: Hero(
              tag: "To_Flutter",
              child: FlutterLogo(size: 50,),
            )),
      ),
    )
  );
}

class FlutterPage extends StatelessWidget {
  const FlutterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Hero Animation'),
      ),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 190,
            child: Center(
              child: Hero(
                tag: 'To_Flutter',
                child: FlutterLogo(size: 250,),
              ),
            ),
          )
        ],
      ),
    );
  }
}

