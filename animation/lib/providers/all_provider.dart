import 'package:animation/models/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:animation/dummy_data.dart';

class AllProvider with ChangeNotifier {
  List<AllModel> allAnimation = [];
  List<AllModel> allUI = [];

  void setData() {
    allAnimation.clear();
    allUI.clear();
    DUMMY_ANIMATION.forEach((cat) => allAnimation.add(cat));
    DUMMY_UI.forEach((cat) => allUI.add(cat));
  }

  void getData() {
    setData();
  }



}