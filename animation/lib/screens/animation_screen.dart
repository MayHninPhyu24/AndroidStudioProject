import 'package:animation/providers/all_provider.dart';
import 'package:animation/widgets/Item.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';

class AnimationScreen extends StatelessWidget {
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: GridView(
          padding: EdgeInsets.all(25),
          children: Provider.of<AllProvider>(context).allAnimation.map((catData) =>
              Item(catData.id, catData.title,'animation'),
          ).toList(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 100,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 3/2,
          ),
        ),
      ),
    );
  }
}
