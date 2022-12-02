import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';

class AnimationScreenA5 extends StatefulWidget {
  static const routeName = "/AnimationScreenA5";

  const AnimationScreenA5({Key? key}) : super(key: key);

  @override
  _AnimationScreenA5State createState() => _AnimationScreenA5State();
}

class _AnimationScreenA5State extends State<AnimationScreenA5> {
  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute.of(context)!.settings.arguments as Map<String , String>;

    return Scaffold(
      appBar: AppBar(title: Text('${routeArg["title"]}'),),
      body: WidgetWithCodeView(
        child: SomeWidget(),
        sourceFilePath: 'lib/animation_screens/a5.dart',
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
  double dx = 0;
  double dy = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Container(
        height: 300,
        width: 300,
        color: Colors.yellow[200],
        child: AnimatedAlign(
          duration: Duration(seconds: 1),
          alignment: FractionalOffset(dx, dy),
          // alignment: Alignment(
          //   0.2,0.6  //0,0 is center
          // ),
          child: FlutterLogo(size: 60,),
        ),
      )
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: (){
        setState(() {
            dx = (dx==0 ? 1:0);
            dy = (dy==0 ? 1:0);
        });
      },
      child: Icon(Icons.play_arrow),
    ),
  );
}
