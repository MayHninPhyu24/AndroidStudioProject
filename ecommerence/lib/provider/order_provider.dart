import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerence/models/order_attr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderProvider with ChangeNotifier {
  List<OrderAttr> _orders = [];

  Future<void> fetchOrders() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User _user = _auth.currentUser!;
   try{
     await FirebaseFirestore.instance.collection('order')
         .where('user_id', isEqualTo: _user.uid)
         .get()
         .then((QuerySnapshot orderSnapshot){
       _orders = [];

       orderSnapshot.docs.forEach((element) {
         _orders.insert(
             0,
             OrderAttr(
               orderId: element.get('order_id'),
               userId: element.get('user_id'),
               productId: element.get('product_id'),
               title: element.get('title'),
               price: element.get('price').toString(),
               imageUrl:element.get('imageUrl'),
               quantity: element.get('quantity').toString(),
               orderDate: element.get('orderDate'),
             ));
       });
     });
   }catch(err){
     print('Printing error while fetching order $err');
   }
    notifyListeners();
  }

  List<OrderAttr> get getOrders {
    return [..._orders];
  }
}