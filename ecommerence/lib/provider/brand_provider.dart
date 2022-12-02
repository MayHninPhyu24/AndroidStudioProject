import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerence/models/brand_attr.dart';
import 'package:flutter/material.dart';

class BrandProvider with ChangeNotifier {
  List<BrandAttr> _brands= [];

  Future<void> fetchBrand() async {
    await FirebaseFirestore.instance.collection('brands').get()
        .then((QuerySnapshot brandSnapshot){
      _brands = [];
      brandSnapshot.docs.forEach((element) {
        _brands.insert(0, BrandAttr(
          id: element.get('brandId'),
          title: element.get('brandTitle'),
          imageUrl:element.get('brandImage'),
        ));
      });
    });

  }
  List<BrandAttr> get brands{
    return [..._brands];
  }

}