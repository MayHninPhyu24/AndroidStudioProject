import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meal_app/providers/language_provider.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = 'category_meals';

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  List<Meal> displayMeals = <Meal>[];
  String categoryId = '';

  @override
  void didChangeDependencies() {
    final List<Meal> availableMeals = Provider.of<MealProvider>(context,listen: true).availableMeals;
    final routeArg = ModalRoute.of(context)!.settings.arguments as Map<String , String>;
    categoryId = routeArg['id']!;
    displayMeals = availableMeals.where((meal){
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId){
    setState(() {
      displayMeals.removeWhere((meal) => meal.id == mealId);
    });
  }
  @override
  Widget build(BuildContext context) {
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    var dw =  MediaQuery.of(context).size.width;
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    return Directionality(
      textDirection: lan.isEn? TextDirection.ltr: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text('${lan.getTexts("cat-$categoryId")}')),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: dw<= 400? 400.0: 500.0,
            mainAxisSpacing: 0.0,
            crossAxisSpacing: 0.0,
            childAspectRatio: isLandscape? dw/(dw*0.71): dw/(dw * 0.715),
          ),
          itemBuilder: (ctx,index) {
            return MealItem(
              id: displayMeals[index].id,
              imageUrl : displayMeals[index].imageUrl,
              duration: displayMeals[index].duration,
              complexity: displayMeals[index].complexity,
              affordability: displayMeals[index].affordability,
              // removeItem: _removeMeal
            );
          },
          itemCount: displayMeals.length,
        ),
      ),
    );
  }
}
