import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerence/models/product.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  Future<void> fetchProducts() async {
    await FirebaseFirestore.instance.collection('products').get()
    .then((QuerySnapshot productSnapshot){
          _products = [];
        productSnapshot.docs.forEach((element) {
          print(element.get('price').runtimeType);
          print(element.get('productQuantity').runtimeType);

          _products.insert(0, Product(
              id: element.get('productId'),
              title: element.get('productTitle'),
              description:element.get('productDescription'),
              price: double.parse(element.get('price')),
              imageUrl:element.get('productImage'),
              brand: element.get('productBrand'),
              productCategoryName: element.get('productCategory'),
              quantity: int.parse(element.get('productQuantity')),
              isPopular: true,
              isFavorite: false
          ));
        });
    });
  }
  List<Product> get products{
    return [..._products];
  }

  List<Product> get popularProducts{
    return _products.where((element) => element.isPopular).toList();
  }

  Product findById(String id) {
    return _products.firstWhere((element) => element.id == id);
  }
  List<Product> findByCategory (String categoryName){
    List<Product> _categoryList = _products.where((element) =>
        element.productCategoryName.toLowerCase().contains(categoryName.toLowerCase())).toList();
    return _categoryList;
  }
  List<Product> findByBrand (String brandyName){
    List<Product> _productList = _products.where((element) =>
        element.brand.toLowerCase().contains(brandyName.toLowerCase())).toList();
    return _productList;
  }

  List<Product> searchQuery (String searchText){
    List<Product> _searchList = _products.where((element) =>
        element.title.toLowerCase().contains(searchText.toLowerCase())).toList();
    return _searchList;
  }
}