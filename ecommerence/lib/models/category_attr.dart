import 'package:flutter/cupertino.dart';

class CategoryAttr with ChangeNotifier{
  final String id;
  final String title;
  final String imageUrl;

  CategoryAttr({required this.id, required this.title, required this.imageUrl});

}
