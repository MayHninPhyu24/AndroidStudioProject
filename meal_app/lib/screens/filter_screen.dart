import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatelessWidget {
  static const routeName = '/filters';

  final bool fromOnBoarding;

  FilterScreen({this.fromOnBoarding = false});

  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _vegetarian = false;

  // @override
  // initState() {
  //   final Map<String, bool> currentFilters = Provider.of<MealProvider>(context,listen: false).filters;
  //   _glutenFree = currentFilters['gluten']?? currentFilters['gluten']!;
  //   _lactoseFree = currentFilters['lactose']?? currentFilters['lactose']!;
  //   _vegan = currentFilters['vegan']?? currentFilters['vegan']!;
  //   _vegetarian = currentFilters['vegetarian']??currentFilters['vegetarian']!;
  //   super.initState();
  // }
  Widget buildSwitchListTile(String title, String description, bool currentValue, Function(bool) updateValue,BuildContext ctx
      )=> SwitchListTile(
        title: Text(title, style: Theme.of(ctx).textTheme.headline6),
        value: currentValue,
        subtitle: Text(description, style:Theme.of(ctx).textTheme.headline6),
        onChanged: updateValue,
        inactiveTrackColor: Provider.of<ThemeProvider>(ctx, listen: true).tm == ThemeMode.light
        ? null : Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> currentFilters = Provider.of<MealProvider>(context,listen: false).filters;
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    return Directionality(
      textDirection: lan.isEn? TextDirection.ltr: TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              title: fromOnBoarding? null: Text('${lan.getTexts("filters_appBar_title")}'),
              backgroundColor: fromOnBoarding? Theme.of(context).canvasColor:
              Theme.of(context).colorScheme.primary ,
              elevation: fromOnBoarding? 0: 5,
            ),
            SliverList(delegate: SliverChildListDelegate([
              Container(
                padding: EdgeInsets.all(20),
                child: Text("${lan.getTexts('filters_screen_title')}",
                  style: Theme.of(context).textTheme.headline6, textAlign: TextAlign.center,),
              ),

                  buildSwitchListTile(
                      "${lan.getTexts('Gluten-free')}",
                      "${lan.getTexts('Gluten-free-sub')}",
                      currentFilters['gluten']!,
                          (newvalue){
                          currentFilters['gluten'] = newvalue;
                          Provider.of<MealProvider>(context,listen: false).setFilters();
                      },
                      context
                  ),
                  buildSwitchListTile(
                      "${lan.getTexts('Lactose-free')}",
                      "${lan.getTexts('Lactose-free_sub')}" ,
                      currentFilters['lactose']! ,
                          (newvalue){
                          currentFilters['lactose'] = newvalue;
                          Provider.of<MealProvider>(context,listen: false).setFilters();
                      },
                      context
                  ),
                  buildSwitchListTile(
                      "${lan.getTexts('Vegan')}",
                      "${lan.getTexts('Vegan-sub')}" ,
                      currentFilters['vegan']! ,
                          (newvalue){
                          currentFilters['vegan'] = newvalue;
                          Provider.of<MealProvider>(context,listen: false).setFilters();
                      },
                      context
                  ),
                  buildSwitchListTile(
                      "${lan.getTexts('Vegetarian')}",
                      "${lan.getTexts('Vegetarian-sub')}" ,
                      currentFilters['vegetarian']! ,
                          (newvalue){
                          currentFilters['vegetarian'] = newvalue;
                          Provider.of<MealProvider>(context,listen: false).setFilters();
                      },
                      context
                  ),

              SizedBox(height: fromOnBoarding? 80: 0,)
            ]))
          ],
        ),
        drawer: fromOnBoarding? null : MainDrawer(),
      ),
    );
  }
}

