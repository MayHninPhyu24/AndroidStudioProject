import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerence/models/category_attr.dart';
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryAttr> _categories= [];

  Future<void> fetchCategory() async {
    await FirebaseFirestore.instance.collection('categories').get()
        .then((QuerySnapshot categorySnapshot){
      _categories = [];
      categorySnapshot.docs.forEach((element) {
        _categories.insert(0, CategoryAttr(
            id: element.get('categoryId'),
            title: element.get('categoryTitle'),
            imageUrl:element.get('categoryImage'),
        ));
      });
    });

  }
  List<CategoryAttr> get categories{
    return [..._categories];
  }
  
}