import 'package:animation/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
class DartIntroScreen extends StatelessWidget {
  static const routeName = "/DartIntroScreen";

  const DartIntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dart Introduction'),
      ),
      body: null,
      drawer: MainDrawer(),

    );
  }
}
