import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/screens/filter_screen.dart';
import 'package:meal_app/screens/onboarding_screen.dart';
import 'package:meal_app/screens/theme_screen.dart';
import './screens/tabs_screen.dart';
import '../models/meal.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/category_screen.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  Widget homeScreen = (prefs.getBool('watched')?? false)? TabsScreen(): OnBoardingScreen();

  runApp(
     MultiProvider(
       providers: [
         ChangeNotifierProvider<MealProvider>(
           create:(ctx)=> MealProvider(),
         ),
         ChangeNotifierProvider<ThemeProvider>(
           create:(ctx)=> ThemeProvider(),
         ),
         ChangeNotifierProvider<LanguageProvider>(
           create:(ctx)=> LanguageProvider(),
         ),
       ],
       child: MyHomePage(homeScreen),
     )
  );
}

class MyHomePage extends StatelessWidget {
  final Widget mainScreen;
  MyHomePage(this.mainScreen);

  @override
  Widget build(BuildContext context) {
    var primaryColor = Provider.of<ThemeProvider>(context, listen: true).primaryColor;
    var accentColor = Provider.of<ThemeProvider>(context, listen: true).accentColor;
    var tm = Provider.of<ThemeProvider>(context,listen: true).tm;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: tm,
      theme: ThemeData(
          canvasColor: Color.fromRGBO(255, 254, 229 ,1),
          fontFamily: 'Raleway',
          splashColor: Colors.black87,
          buttonTheme: ButtonThemeData(buttonColor: Colors.black87),
          cardColor: Colors.white,
          shadowColor: Colors.black54,
          textTheme: ThemeData.dark().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 50, 50, 1),
              ),
              headline6: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold
              )
          ), colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColor).copyWith(secondary: accentColor)
      ),
      darkTheme: ThemeData(
          canvasColor: Color.fromRGBO(14,22, 33, 1),
          fontFamily: 'Raleway',
          splashColor: Colors.white70,
          buttonTheme: ButtonThemeData(buttonColor: Colors.white70,),
          cardColor: Color.fromRGBO(35,34, 39, 1),
          shadowColor: Colors.white60,
          unselectedWidgetColor: Colors.white70,
          textTheme: ThemeData.dark().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Colors.white60,
              ),
              headline6: TextStyle(
                color: Colors.white70,
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold
              )
          ), colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColor).copyWith(secondary: accentColor)
      ),
      //home: CategoriesScreen(),
      routes: {
        '/': (context) => mainScreen,  //CategoriesScreen
        TabsScreen.routeName: (context) => TabsScreen(),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(),
        MealDetailScreen.routeName: (context) => MealDetailScreen(),
        FilterScreen.routeName: (context) => FilterScreen(),
        ThemeScreen.routeName: (context) => ThemeScreen(),
      },
    );
  }

}