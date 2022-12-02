import 'package:animation/providers/all_provider.dart';
import 'package:animation/widgets/Item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/main_drawer.dart';

class FlutterUIScreen extends StatelessWidget {

  static const routeName = "/FlutterUIScreen";

  bool visible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('More Flutter UI'),
        ),
        body: GridView(
          padding: EdgeInsets.all(25),
          children: Provider.of<AllProvider>(context).allUI.map((catData) =>
              Item(catData.id, catData.title,'ui'),
          ).toList(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 100,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 3/2,
          ),
        ),
      drawer: MainDrawer(),

    );
  }
}
