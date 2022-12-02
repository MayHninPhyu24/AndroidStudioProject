import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';

class MealDetailScreen extends StatefulWidget {
  static const routeName = "meal_detail";

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  Widget buildSectionTitle(BuildContext context,String text){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(text, style:Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildContainer(Widget child, BuildContext context){
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    var dw =  MediaQuery.of(context).size.width;
    var dh =  MediaQuery.of(context).size.height;

    return  Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color:Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: isLandscape? dh*0.5 : dh*0.25,
      width: isLandscape? (dw* 0.5 - 30) : dw,
      child: child,
    );
  }

  bool useWhiteForeground(Color backgroundColor, {double bias = 0.0}) {
    // Old:
    // return 1.05 / (color.computeLuminance() + 0.05) > 4.5;

    // New:
    int v = sqrt(pow(backgroundColor.red, 2) * 0.299 +
        pow(backgroundColor.green, 2) * 0.587 +
        pow(backgroundColor.blue, 2) * 0.114)
        .round();
    return v < 130 + bias ? true : false;
  }

  String mealId = '';

  @override
  void didChangeDependencies() {
    mealId = ModalRoute.of(context)!.settings.arguments as String;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) =>meal.id == mealId);
    var accentColor = Theme.of(context).colorScheme.secondary;
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    List<String> ingredientLi = lan.getTexts('ingredients-$mealId') as List<String>;
    List<String> stepsLi = lan.getTexts('steps-$mealId') as List<String>;
    var liIngredients = ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder: (ctx, index)=> Card(
          color: accentColor,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text('${ingredientLi[index]}',
              style: TextStyle(color: useWhiteForeground(accentColor)? Colors.white: Colors.black),),
          )
      ),
      itemCount: ingredientLi.length,
    );

    var liSteps = ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder: (ctx, index)=> Column(

        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text('# ${index+1}',),
              backgroundColor: Theme.of(ctx).colorScheme.secondary,
            ),
            title: Text(stepsLi[index].toString(),
              style: TextStyle(
                color: useWhiteForeground(accentColor)? Colors.white: Colors.black
              ),
            ),
          ),
          Divider(),
        ],
      ),
      itemCount: stepsLi.length,
    );

    return Directionality(
      textDirection: lan.isEn? TextDirection.ltr: TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('${lan.getTexts("meal-$mealId")}'),
                background: Hero(
                  tag: mealId,
                  child: InteractiveViewer(
                    child: FadeInImage(
                      placeholder: AssetImage('assets/images/a2.png'),
                      image: NetworkImage(selectedMeal.imageUrl),
                      fit: BoxFit.cover,
                    )),

                ),
              ),
            ),
            SliverList(delegate: SliverChildListDelegate([
              if(isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        buildSectionTitle(context, "${lan.getTexts('Ingredients')}"),
                        buildContainer(liIngredients,context),
                      ],
                    ),
                    Column(
                      children: [
                        buildSectionTitle(context, "${lan.getTexts('Steps')}"),
                        buildContainer(liSteps,context),
                      ],
                    ),
                  ],
                ),

              if(!isLandscape)  buildSectionTitle(context, "${lan.getTexts('Ingredients')}"),
              if(!isLandscape)  buildContainer(liIngredients,context),
              if(!isLandscape)  buildSectionTitle(context, "${lan.getTexts('Steps')}"),
              if(!isLandscape)  buildContainer(liSteps,context),
            ],),),
          ],
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: ()=>Provider.of<MealProvider>(context,listen: false).toggleFavourite(mealId),
          child: Icon(
            Provider.of<MealProvider>(context,listen: true).isFavourite(mealId)? Icons.star: Icons.star_border,
          ),
        ),
      ),
    );
  }
}
