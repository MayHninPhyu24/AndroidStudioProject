import 'dart:math';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';

class AnimationScreenA17 extends StatefulWidget {
  static const routeName = "/AnimationScreenA17";

  const AnimationScreenA17({Key? key}) : super(key: key);

  @override
  _AnimationScreenA17State createState() => _AnimationScreenA17State();
}

class _AnimationScreenA17State extends State<AnimationScreenA17> {
  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute.of(context)!.settings.arguments as Map<String , String>;

    return Scaffold(
      appBar: AppBar(title: Text('${routeArg["title"]}'),),
      body: WidgetWithCodeView(
        child: SomeWidget(),
        sourceFilePath: 'lib/animation_screens/a17.dart',
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LikeButton(
            size: 60,
            likeCount: 900,
            onTap: onLikeButtonTapped,
            bubblesColor: BubblesColor(
              dotPrimaryColor: Color(0xff33b5e5),
              dotSecondaryColor: Color(0xff0099cc),
            ),
            circleColor: CircleColor(
              start: Color(0xff00ddff),
              end: Color(0xff0099cc),
            ),
          ),
          LikeButton(
            likeBuilder: (bool isLiked) {
              return Icon(
                Icons.home,
                size: 60,
                color: isLiked? Colors.deepPurpleAccent: Colors.grey,
              );
            },
            likeCountPadding:	const EdgeInsets.only(left: 30.0),
            likeCount: 900,
            onTap: onLikeButtonTapped,
            bubblesColor: BubblesColor(
              dotPrimaryColor: Color(0xff33b5e5),
              dotSecondaryColor: Color(0xff0099cc),
            ),
            circleColor: CircleColor(
              start: Color(0xff00ddff),
              end: Color(0xff0099cc),
            ),
          ),
        ],
      ),
    ),
  );

  Future<bool> onLikeButtonTapped(bool isLiked) async => !isLiked;
}

