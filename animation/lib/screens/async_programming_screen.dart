import 'package:animation/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
class AsyncProgrammingScreen extends StatelessWidget {
  static const routeName = "/AsyncProgrammingScreen";

  const AsyncProgrammingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Async Programming'),
      ),
      body: null,
      drawer: MainDrawer(),

    );
  }
}
