import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';

class AnimationScreenA13 extends StatefulWidget {
  static const routeName = "/AnimationScreenA13";

  const AnimationScreenA13({Key? key}) : super(key: key);

  @override
  _AnimationScreenA13State createState() => _AnimationScreenA13State();
}

class _AnimationScreenA13State extends State<AnimationScreenA13> {
  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute.of(context)!.settings.arguments as Map<String , String>;

    return Scaffold(
      appBar: AppBar(title: Text('${routeArg["title"]}'),),
      body: WidgetWithCodeView(
        child: SomeWidget(),
        sourceFilePath: 'lib/animation_screens/a13.dart',
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
      child: Container(
        height: 300,
        width: 300,
        child: FadeInImage(
          placeholder: NetworkImage('https://myanbox.com.mm/images/myanbox_fav.png'),
          image: NetworkImage('https://myanbox.com.mm/images/logo/logo.png'),
        ),
      ),
    ),
  );
}

