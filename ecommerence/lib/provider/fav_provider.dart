import 'package:ecommerence/models/cart_attr.dart';
import 'package:ecommerence/models/fav_attr.dart';
import 'package:flutter/material.dart';

class FavProvider with ChangeNotifier {
  Map<String, FavAttr> _favItems = {};

  Map<String, FavAttr> get favItems {
    return {..._favItems};
  }


  void addAndRemoveFromFav(String productId, double price, String title,
      String imageUrl){
    if(_favItems.containsKey(productId)) {
      removeItem(productId);
    }
    else{
      _favItems.putIfAbsent(productId, () => FavAttr(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          imageUrl: imageUrl
      ));
    }
    notifyListeners();
  }



  void removeItem(String productId) {
    _favItems.remove(productId);
    notifyListeners();
  }

  void clearFav() {
    _favItems.clear();
    notifyListeners();
  }
}