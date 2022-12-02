import 'dart:math';

import 'package:animation/animation_screens/a10.dart';
import 'package:animation/animation_screens/a11.dart';
import 'package:animation/animation_screens/a14.dart';
import 'package:animation/animation_screens/a15.dart';
import 'package:animation/animation_screens/a16.dart';
import 'package:animation/animation_screens/a17.dart';
import 'package:animation/animation_screens/a9.dart';
import 'package:animation/more_flutter_ui_screens/ui3.dart';
import 'package:flutter/material.dart';

import '../animation_screens/a1.dart';
import '../animation_screens/a12.dart';
import '../animation_screens/a13.dart';
import '../animation_screens/a2.dart';
import '../animation_screens/a3.dart';
import '../animation_screens/a4.dart';
import '../animation_screens/a5.dart';
import '../animation_screens/a6.dart';
import '../animation_screens/a7.dart';
import '../animation_screens/a8.dart';
import '../more_flutter_ui_screens/ui1.dart';
import '../more_flutter_ui_screens/ui2.dart';
import '../more_flutter_ui_screens/ui4.dart';
import '../more_flutter_ui_screens/ui5.dart';

class Item extends StatelessWidget {
  final String id;
  final String title;
  final String type;

  const Item(this.id,this.title, this.type);


  void selectCategory(BuildContext ctx, String type) {
    late String path;
    if(type == 'animation') {
      switch(id){
        case 'A1': path = AnimationScreenA1.routeName;
        break;
        case 'A2': path = AnimationScreenA2.routeName;
        break;
        case 'A3': path = AnimationScreenA3.routeName;
        break;
        case 'A4': path = AnimationScreenA4.routeName;
        break;
        case 'A5': path = AnimationScreenA5.routeName;
        break;
        case 'A6': path = AnimationScreenA6.routeName;
        break;
        case 'A7': path = AnimationScreenA7.routeName;
        break;
        case 'A8': path = AnimationScreenA8.routeName;
        break;
        case 'A9': path = AnimationScreenA9.routeName;
        break;
        case 'A10': path = AnimationScreenA10.routeName;
        break;
        case 'A11': path = AnimationScreenA11.routeName;
        break;
        case 'A12': path = AnimationScreenA12.routeName;
        break;
        case 'A13': path = AnimationScreenA13.routeName;
        break;
        case 'A14': path = AnimationScreenA14.routeName;
        break;
        case 'A15': path = AnimationScreenA15.routeName;
        break;
        case 'A16': path = AnimationScreenA16.routeName;
        break;
        case 'A17': path = AnimationScreenA17.routeName;
        break;
        default: path = AnimationScreenA1.routeName; break;
      }
    } else {
      switch(id) {
        case 'UI1':
          path = MoreFlutterUI1.routeName;
          break;
        case 'UI2':
          path = MoreFlutterUI2.routeName;
          break;
        case 'UI3':
          path = MoreFlutterUI3.routeName;
          break;
        case 'UI4':
          path = MoreFlutterUI4.routeName;
          break;
        case 'UI5':
          path = MoreFlutterUI5.routeName;
          break;
      }
    }

    Navigator.of(ctx).pushNamed(path,arguments: {
      'title' : title,
    });
  }

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    Color item_color = Color.fromRGBO(random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256), 1);

    return InkWell(
      onTap: () =>selectCategory(context,type),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(title.toString(),style: Theme.of(context).textTheme.headline6,),
        decoration: BoxDecoration(
          color: item_color,
          gradient: LinearGradient(
              colors: [
                item_color.withOpacity(0.3),
                item_color,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
