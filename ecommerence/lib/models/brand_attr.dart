import 'package:flutter/cupertino.dart';

class BrandAttr with ChangeNotifier{
  final String id;
  final String title;
  final String imageUrl;

  BrandAttr({required this.id, required this.title, required this.imageUrl});

}
