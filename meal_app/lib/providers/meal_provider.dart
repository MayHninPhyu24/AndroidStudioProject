import 'package:flutter/cupertino.dart';
import 'package:meal_app/models/category.dart';
import '../models/meal.dart';
import '../dummy_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MealProvider with ChangeNotifier{

  Map<String, bool> filters = {
    'gluten' :false,
    'lactose' : false,
    'vegan' : false,
    'vegetarian' : false,
  };
  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favouriteMeals = [];
  List<String>? prefsMealId = [];
  List<Category> availableCategory = [];

  void setFilters() async{ //Map<String, bool> filterData
    //filters = filterData;

    availableMeals = DUMMY_MEALS.where((meal) {
      if (filters['gluten']! as bool && !meal.isGlutenFree) {
        return false;
      }
      if (filters['lactose']! as bool && !meal.isLactoseFree) {
        return false;
      }
      if (filters['vegan']! as bool && !meal.isVegan) {
        return false;
      }
      if (filters['vegetarian']! as bool && !meal.isVegetarian) {
        return false;
      }

      return true; // <--- I was missing this return

    }).toList();



    List<Category> ac = [];
    availableMeals.forEach((meal) { 
      meal.categories.forEach((catId) {
        DUMMY_CATEGORIES.forEach((cat) {
          if(cat.id == catId){
            if (!ac.any((cat) => cat.id == catId)) ac.add(cat);
          }
        });
      });
    });
    availableCategory = ac;

    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("gluten", filters['gluten']!);
    prefs.setBool("lactose", filters['lactose']!);
    prefs.setBool("vegan", filters['vegan']!);
    prefs.setBool("vegetarian", filters['vegetarian']!);

  }

  void getData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    filters['gluten'] = prefs.getBool("gluten")?? false;
    filters['lactose'] = prefs.getBool("lactose")?? false;
    filters['vegan'] = prefs.getBool("vegan")?? false;
    filters['vegetarian'] = prefs.getBool("vegetarian")?? false;
    setFilters();
    prefsMealId = prefs.getStringList("prefsMealId")?? [];
      for(var mealId in prefsMealId!){
        final existingIndex = favouriteMeals.indexWhere((meal) => meal.id == mealId);
        if (existingIndex < 0) {
          favouriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
        }
      }

    List<Meal> fm = [];
    favouriteMeals.forEach((favMeal) {
      availableMeals.forEach((avMeal) {
        if(favMeal.id == avMeal.id) {
          fm.add(favMeal);
        }
      });
    });
    favouriteMeals = fm;

    notifyListeners();
  }

  bool isMealFavourite = false;

  void  toggleFavourite(String mealId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final existingIndex = favouriteMeals.indexWhere((meal) => meal.id == mealId);
    if(existingIndex >=0 ){
      favouriteMeals.removeAt(existingIndex);
      prefsMealId?.remove(mealId);
    }
    else{
      favouriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      prefsMealId?.add(mealId);
    }

    isMealFavourite = favouriteMeals.any((meal) => meal.id == mealId);

    notifyListeners();
    prefs.setStringList("prefsMealId",prefsMealId!);

  }

   bool isFavourite(String mealId) {
    return favouriteMeals.any((meal) => meal.id == mealId);
   }
}