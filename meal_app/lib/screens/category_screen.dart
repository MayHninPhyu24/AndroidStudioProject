import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/widgets/category_item.dart';
import '../dummy_data.dart';
import 'package:provider/provider.dart';


class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: EdgeInsets.all(25),
        children: Provider.of<MealProvider>(context).availableCategory.map((catData) =>
            CategoryItem(catData.id, catData.color),
        ).toList(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 100,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 3/2,
        ),
      ),
    );

  }
}
