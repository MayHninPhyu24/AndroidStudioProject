import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/model/product_attr.dart';
import 'package:untitled1/provider/product_provider.dart';
import 'package:untitled1/update_product.dart';

class ProductDetail extends StatelessWidget {
  // final String id;
  static String routeName = "/ProductDetail";

  // ProductDetail(this.id);

  @override
  Widget build(BuildContext context) {
    List<ProductAttr> productAttr = Provider.of<ProductProvider>(context,listen: true).productList;
    final id = ModalRoute.of(context)!.settings.arguments as String;
    ProductAttr? filteredItem;
    try{
      filteredItem = productAttr.firstWhere((element)
      => element.id == id);
    }catch(e) {
      filteredItem = null;
    }

    return Scaffold(
      appBar: AppBar(
        title: filteredItem == null? null: Text(filteredItem.title),
        backgroundColor: Colors.amber,
        actions: [
          // FlatButton(onPressed: ()=> Provider.of<ProductProvider>(context,
          //     listen: false).updateData(filteredItem.id),
          //     child: Text("Update Data")),
          
          FlatButton(onPressed: ()=>  Navigator.pushNamed(context,
              UpdateProduct.routeName,
              arguments: id
          ), child: Text('Update Data')),
        ],
      ),
      body: filteredItem == null
      ? null
      : ListView(
        children: [
          SizedBox(height: 10,),
          buildContainer(filteredItem.imageUrl, filteredItem.id),
          SizedBox(height: 10,),
          buildCard(filteredItem.title, filteredItem.description, filteredItem.price)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: (){
          Provider.of<ProductProvider>(context,
                  listen: false).delete(filteredItem!.id);
          Navigator.pop(context, filteredItem.id);
        },
        child: Icon(Icons.delete, color: Colors.black,),
      ),
    );
  }

  Container buildContainer(String image, String id) {
    return Container(
      width: double.infinity,
      child: Center(
        child: Hero(
          tag: id,
          child: Image.network(image),
        ),
      ),
    );
  }

  Card buildCard(String title, String desc, double price) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(7),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(color: Colors.black),
            Text(desc,
                style: TextStyle(fontSize: 16), textAlign: TextAlign.justify),
            Divider(color: Colors.black),
            Text(
              "\$$price",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

}

