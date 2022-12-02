import 'package:ecommerence/models/category_attr.dart';
import 'package:ecommerence/provider/category_provider.dart';
import 'package:ecommerence/screens/category_feeds.dart';
import 'package:ecommerence/screens/feeds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatefulWidget {
  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {

  // final int index;
  @override
  Widget build(BuildContext context) {
    final categoryAttribute = Provider.of<CategoryAttr>(context);

    return Stack(
      children:[
        InkWell(
          onTap: (){
            Navigator.of(context).pushNamed(CategoryFeedsScreen.routeName,
            arguments: categoryAttribute.title);
          },
          child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: NetworkImage(categoryAttribute.imageUrl as String),
                fit: BoxFit.cover
            ),
          ),
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: 150,
          height: 150,
      ),
        ),
    Positioned(
      bottom: 0,
      left: 10,
      right: 10,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      color: Theme.of(context).backgroundColor,
      child: Text(categoryAttribute.title as String,
      style: TextStyle(fontWeight: FontWeight.w500,
      fontSize: 18, color: Theme.of(context).textSelectionColor
      ),),
      ),
      ),
    ],);
  }
}
