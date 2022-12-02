import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/screens/filter_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'package:meal_app/screens/theme_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'meal_detail_screen.dart';

class OnBoardingScreen extends StatefulWidget {

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentIndex = 0;

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

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage("assets/images/image.jpg"),
                    fit: BoxFit.cover,
                  )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 300,
                      color: Theme.of(context).shadowColor,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Text('${lan.getTexts("drawer_name")}',
                              style: Theme.of(context).textTheme.headline5,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                      ),
                    ),
                    Container(
                      width: 350,
                      color: Theme.of(context).shadowColor,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Text("${lan.getTexts('drawer_switch_title')}",
                            style: Theme.of(context).textTheme.headline5,
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${lan.getTexts('drawer_switch_item2')}",
                                style: Theme.of(context).textTheme.headline5
                              ),
                              Switch(value: lan.isEn,
                                  onChanged: (newValue){
                                    Provider.of<LanguageProvider>(context,listen: false).changeLan(newValue);
                                  }),
                              Text("${lan.getTexts('drawer_switch_item1')}",
                                style: Theme.of(context).textTheme.headline5,
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              ThemeScreen(fromOnBoarding: true),
              FilterScreen(fromOnBoarding: true),
            ],
            onPageChanged: (val) {
              setState(() {
                _currentIndex = val;
              });
           },
          ),
          Indicator(_currentIndex),
          Builder(
            builder: (ctx) => Align(
              alignment: Alignment(0, 0.85),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(lan.isEn? EdgeInsets.all(7)
                          : EdgeInsets.all(0)),
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                    ),
                    child: Text("${lan.getTexts('start')}",
                      style: TextStyle(
                        color: useWhiteForeground(primaryColor)
                              ? Colors.white
                              : Colors.black,
                      ),
                    ),
                    onPressed: () async{
                      Navigator.of(ctx).pushReplacementNamed(TabsScreen.routeName);

                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setBool('watched', true);
                           },

                  ),
                ),
            )

            ),

        ],

      ),
    );
  }
}


class Indicator extends StatelessWidget {
  final int index;

  Indicator(this.index);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildContainer(context, 0),
          buildContainer(context, 1),
          buildContainer(context, 2),
        ],
      ),
    );
  }

  Widget buildContainer(BuildContext ctx, int i) {
    return index == i
        ? Icon(Icons.star, color: Theme.of(ctx).primaryColor,)
        : Container(
          margin: EdgeInsets.all(4),
          height: 15,
          width:  15,
          decoration: BoxDecoration(
            color: Theme.of(ctx).colorScheme.secondary,
            shape: BoxShape.circle,
          ),
    );

  }
}