import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/provider/product_provider.dart';

import 'model/product_attr.dart';

class UpdateProduct extends StatefulWidget {
  static String routeName = "/UpdateProduct";
  @override
  _UpdateProductState createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {

  String title = "";
  String description = "";
  String price = "";
  String imageUrl = "";
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    List<ProductAttr> productAttr = Provider.of<ProductProvider>(context,listen: true).productList;
    final id = ModalRoute.of(context)!.settings.arguments as String;
    var filteredItem = productAttr.firstWhere((element) => element.id == id, orElse: () => null as ProductAttr);

    return Scaffold(
      appBar: AppBar(
        title:  Text('Update Product'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          :Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            TextFormField(
              initialValue: filteredItem.title,
              decoration: InputDecoration(labelText: 'Title',
                  hintText: "Add Title"
              ),
              onChanged: (text) => setState(() => title = text),
            ),
            TextFormField(

              decoration: InputDecoration(labelText: 'Description',
                  hintText: "Add Description"
              ),
              initialValue: filteredItem.description,
              onChanged: (text) => setState(() => description = text),
            ),
            TextFormField(
              // initialValue: filteredItem.price as String,
              decoration: InputDecoration(labelText: 'Price',
                  hintText: "Add Price"
              ),
              onChanged: (text) => setState(() => price = text),
            ),
            TextFormField(
              initialValue: filteredItem.imageUrl,
              decoration: InputDecoration(labelText: 'Image Url',
                  hintText: "Add Image Url"
              ),
              onChanged: (text) => setState(() => imageUrl = text),
            ),
            SizedBox(height: 30,),
            Consumer<ProductProvider>(builder: (ctx, value, _) => RaisedButton(
              color: Colors.orangeAccent,
              textColor: Colors.black,
              child: Text('Update Product'),
              onPressed: () async{
                var doublePrice;
                setState(() {
                  doublePrice = double.tryParse(price) ?? 0.0;
                });

                if(title.isEmpty ||
                    description.isEmpty ||
                    price.isEmpty ||
                    imageUrl.isEmpty
                ){
                  Fluttertoast.showToast(
                      msg: "Please enter all field",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                } else if(doublePrice == 0.0){
                  Fluttertoast.showToast(
                      msg: "Please enter a valid price",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                }
                else{
                  try{
                    setState(() {
                      _isLoading = true;
                    });
                    await value.updateData(
                        id: filteredItem.id,
                        title: title,
                        description: description,
                        price: doublePrice,
                        imageUrl: imageUrl
                    );
                  }catch(error) {
                    return showDialog<Null>(context: context,
                        builder: (innerContext) => AlertDialog(
                          title: Text('An error occured!'),
                          content: Text('Something went wrong'),
                          actions: [
                            FlatButton(onPressed: ()=> Navigator.of(innerContext).pop(),
                                child: Text('OK'))
                          ],
                        ));
                  }finally{
                    setState(() {
                      _isLoading = false;
                    });
                    Navigator.pop(context);
                  }
                }
              },))
          ],
        ),
      ),

    );
  }
}
