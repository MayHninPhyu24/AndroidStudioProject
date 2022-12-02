import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/model/product_attr.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier{
  List<ProductAttr> productList = [];
  String? authToken;

  getData(String? authTok, List<ProductAttr> products){
    authToken = authTok;
    productList = products;
    notifyListeners();
  }
  Future<void> fetchData() async {
    final url = 'https://restapi-d05c3-default-rtdb.firebaseio.com/product.json?auth=$authToken';
    try {
      final http.Response res = await http.get(Uri.parse(url));
      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      extractedData.forEach((prodId, prodData) {
        final prodIndex =
        productList.indexWhere((element) => element.id == prodId);
        if (prodIndex>= 0) {
          productList[prodIndex] = ProductAttr(
            id: prodId ,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
          );
        }
        else {
          productList.add(ProductAttr(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
          ));
         }
      });

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
  Future<void> updateData({
    required String id,
    required String title,
    required String description,
    required double price,
    required String imageUrl
  }) async {
    final url = 'https://restapi-d05c3-default-rtdb.firebaseio.com/product/$id.json?auth=$authToken';
    final prodIndex = productList.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      await http.patch(Uri.parse(url),
          body: json.encode({
            'title': title,
            'description': description,
            'price': price,
            'imageUrl': imageUrl,
          }));
      productList[prodIndex] = ProductAttr(
        id: id,
        title: title,
        description: description,
        price: price,
        imageUrl: imageUrl,
      );
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> add({
    required String id,
    required String title,
    required String description,
    required double price,
    required String imageUrl
  }) async{
    final String url = 'https://restapi-d05c3-default-rtdb.firebaseio.com/product.json?auth=$authToken';
    try{
        http.Response res = await http.post(Uri.parse(url), body: json.encode({
          'id' : id,
          'title' : title,
          'description' : description,
          'price': price,
          'imageUrl': imageUrl
        }));

        productList.add(ProductAttr(
            id: json.decode(res.body)['name'],
            title: title,
            description: description,
            price: price,
            imageUrl: imageUrl)
        );
        notifyListeners();
      }catch(error){
        throw error;
      }
  }

  Future<void> delete(String id) async {
    final url = 'https://restapi-d05c3-default-rtdb.firebaseio.com/product/$id.json?auth=$authToken';

    final prodIndex = productList.indexWhere((element) => element.id == id);
    ProductAttr? prodItem = productList[prodIndex];
    productList.removeAt(prodIndex);
    notifyListeners();

    var res = await http.delete(Uri.parse(url));
    if (res.statusCode >= 400) {
      productList.insert(prodIndex, prodItem);
      notifyListeners();
      print('Could not deleted item');
    } else {
      prodItem = null;
      print('Item deleted');
    }
  }
}