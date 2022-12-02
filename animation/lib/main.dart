import 'dart:math';
import 'package:animation/animation_screens/a10.dart';
import 'package:animation/animation_screens/a11.dart';
import 'package:animation/animation_screens/a12.dart';
import 'package:animation/animation_screens/a13.dart';
import 'package:animation/animation_screens/a14.dart';
import 'package:animation/animation_screens/a15.dart';
import 'package:animation/animation_screens/a16.dart';
import 'package:animation/animation_screens/a17.dart';
import 'package:animation/animation_screens/a6.dart';
import 'package:animation/animation_screens/a7.dart';
import 'package:animation/animation_screens/a8.dart';
import 'package:animation/animation_screens/a9.dart';
import 'package:animation/more_flutter_ui_screens/ui2.dart';
import 'package:animation/more_flutter_ui_screens/ui3.dart';
import 'package:animation/more_flutter_ui_screens/ui4.dart';
import 'package:animation/providers/all_provider.dart';
import 'package:animation/screens/async_programming_screen.dart';
import 'package:animation/screens/dart_intro_screen.dart';
import 'package:animation/screens/flutter_basic_screen.dart';
import 'package:animation/screens/more_ui.dart';
import 'package:animation/screens/state_management_screen.dart';
import 'package:animation/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'animation_screens/a1.dart';
import 'animation_screens/a2.dart';
import 'animation_screens/a3.dart';
import 'animation_screens/a4.dart';
import 'animation_screens/a5.dart';
import 'more_flutter_ui_screens/ui1.dart';
import 'more_flutter_ui_screens/ui5.dart';


void main() {
  Widget homeScreen = TabsScreen();

  Provider.debugCheckInvalidValueType = null;

  runApp(
      Provider<AllProvider>(
        create: (_) => AllProvider(),
        child:  MyApp(homeScreen),
      ),
  );
}

class MyApp extends StatelessWidget {
  final Widget mainScreen;
  MyApp(this.mainScreen);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        iconTheme: IconThemeData(
          color: Colors.pinkAccent,
        ),
        textTheme: TextTheme(
          headline6: TextStyle(
              fontSize: 18,
          ),
        ),
        splashColor: Colors.pinkAccent,
      ),
      routes: {
        '/': (context) => mainScreen, //home Screen
        TabsScreen.routeName: (context) => TabsScreen(),
        DartIntroScreen.routeName: (context) => DartIntroScreen(),
        FlutterBasicScreen.routeName: (context) => FlutterBasicScreen(),
        AsyncProgrammingScreen.routeName: (context) => AsyncProgrammingScreen(),
        StateManagementScreen.routeName: (context) => StateManagementScreen(),
        FlutterUIScreen.routeName: (context) => FlutterUIScreen(),
        AnimationScreenA1.routeName: (context) => AnimationScreenA1(),
        AnimationScreenA2.routeName: (context) => AnimationScreenA2(),
        AnimationScreenA3.routeName: (context) => AnimationScreenA3(),
        AnimationScreenA4.routeName: (context) => AnimationScreenA4(),
        AnimationScreenA5.routeName: (context) => AnimationScreenA5(),
        AnimationScreenA6.routeName: (context) => AnimationScreenA6(),
        AnimationScreenA7.routeName: (context) => AnimationScreenA7(),
        AnimationScreenA8.routeName: (context) => AnimationScreenA8(),
        AnimationScreenA9.routeName: (context) => AnimationScreenA9(),
        AnimationScreenA10.routeName: (context) => AnimationScreenA10(),
        AnimationScreenA11.routeName: (context) => AnimationScreenA11(),
        AnimationScreenA12.routeName: (context) => AnimationScreenA12(),
        AnimationScreenA13.routeName: (context) => AnimationScreenA13(),
        AnimationScreenA14.routeName: (context) => AnimationScreenA14(),
        AnimationScreenA15.routeName: (context) => AnimationScreenA15(),
        AnimationScreenA16.routeName: (context) => AnimationScreenA16(),
        AnimationScreenA17.routeName: (context) => AnimationScreenA17(),

        MoreFlutterUI1.routeName: (context) => MoreFlutterUI1(),
        MoreFlutterUI2.routeName: (context) => MoreFlutterUI2(),
        MoreFlutterUI3.routeName: (context) => MoreFlutterUI3(),
        MoreFlutterUI4.routeName: (context) => MoreFlutterUI4(),
        MoreFlutterUI5.routeName: (context) => MoreFlutterUI5(),

      },
    );
  }
}