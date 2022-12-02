import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/widgets/meal_item.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';

class FavouritesScreen extends StatefulWidget {

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  void initState() {
    Provider.of<MealProvider>(context,listen: false).getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final List<Meal> favouritesMeals = Provider.of<MealProvider>(context,listen: true).favouriteMeals;
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    var dw =  MediaQuery.of(context).size.width;
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    if(favouritesMeals.isEmpty) {
      return Center(
        child: Text('${lan.getTexts("favorites_text")}', style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),),
      );
    }

    return GridView.builder(
      itemBuilder: (ctx,index) {
        return MealItem(
          id: favouritesMeals[index].id,
          imageUrl : favouritesMeals[index].imageUrl,
          duration: favouritesMeals[index].duration,
          complexity: favouritesMeals[index].complexity,
          affordability: favouritesMeals[index].affordability,
          // removeItem: _removeMeal
        );
      },
      itemCount: favouritesMeals.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: dw<= 400? 400.0: 500.0,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        childAspectRatio: isLandscape? dw/(dw*0.71): dw/(dw * 0.715),
      ),
    );
  }
}
