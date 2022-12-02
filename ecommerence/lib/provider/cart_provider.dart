import 'package:ecommerence/models/cart_attr.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartAttr> _cartItems = {};

  Map<String, CartAttr> get CartItems {
    return {..._cartItems};
  }

  double get totalAmount{
    var total = 0.0;
    _cartItems.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addProductToCart(String productId, double price, String title,
      String imageUrl){
    if(_cartItems.containsKey(productId)){
      _cartItems.update(productId, (existingCartItem) => CartAttr(
        id: existingCartItem.id,
        productId: existingCartItem.productId,
        title: existingCartItem.title,
        quantity: existingCartItem.quantity + 1,
        price: existingCartItem.price,
        imageUrl: existingCartItem.imageUrl
      ));
    }else{
        _cartItems.putIfAbsent(productId, () => CartAttr(
            id: DateTime.now().toString(),
            productId: productId,
            title: title,
            quantity: 1,
            price: price,
            imageUrl: imageUrl
        ));
    }
    notifyListeners();
  }

  void reduceCartByOne(String productId){
    if(_cartItems.containsKey(productId)) {
      _cartItems.update(productId, (existingCartItem) =>
          CartAttr(
              id: existingCartItem.id,
              productId: existingCartItem.productId,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity - 1,
              price: existingCartItem.price,
              imageUrl: existingCartItem.imageUrl
          ));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}