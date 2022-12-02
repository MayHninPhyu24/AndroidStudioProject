import 'package:animation/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
class FlutterBasicScreen extends StatelessWidget {
  static const routeName = "/FlutterBasicScreen";

  const FlutterBasicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Basic'),
      ),
      body: null,
      drawer: MainDrawer(),

    );
  }
}
