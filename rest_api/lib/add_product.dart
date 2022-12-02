import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/provider/product_provider.dart';

class AddProduct extends StatefulWidget {

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  String title = "";
  String description = "";
  String price = "";
  String imageUrl = "";
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Add Product'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          :Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title',
                hintText: "Add Title"
              ),
            onChanged: (val) => setState(() => title = val),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Description',
                  hintText: "Add Description"
              ),
              onChanged: (val) => setState(() => description = val),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Price',
                  hintText: "Add Price"
              ),
              onChanged: (val) => setState(() => price = val),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Image Url',
                  hintText: "Add Image Url"
              ),
              onChanged: (val) => setState(() => imageUrl = val),
            ),
            SizedBox(height: 30,),
            Consumer<ProductProvider>(builder: (ctx, value, _) => RaisedButton(
              color: Colors.orangeAccent,
              textColor: Colors.black,
              child: Text('Add Product'),
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
                    await value.add(
                        id: DateTime.now().toString(),
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
