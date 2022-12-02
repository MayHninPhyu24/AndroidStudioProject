import 'package:animation/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class StateManagementScreen extends StatelessWidget {
  static const routeName = "/StateManagementScreen";

  const StateManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('State Management'),
      ),
      body: null,
      drawer: MainDrawer(),

    );
  }
}
