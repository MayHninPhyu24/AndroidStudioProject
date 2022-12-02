import '../../modules/shop_app/login/shop_login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';
import 'package:flutter/material.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if(value){
      print('Logout Token');
      print(token);
      print(value);
      navigateAndFinish(context, ShopLoginScreen(),);
    }
  });

}

void printFullText(String text){
  final pattern = RegExp('.{1,800}'); // 800 is th size of chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
String? token = '';