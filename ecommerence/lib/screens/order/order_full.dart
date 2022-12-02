import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerence/consts/colors.dart';
import 'package:ecommerence/inner_screens/product_detail.dart';
import 'package:ecommerence/models/cart_attr.dart';
import 'package:ecommerence/models/order_attr.dart';
import 'package:ecommerence/provider/cart_provider.dart';
import 'package:ecommerence/provider/dark_theme_provider.dart';
import 'package:ecommerence/services/global_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttericon/zocial_icons.dart';
import 'package:provider/provider.dart';

class OrderFull extends StatefulWidget {
  // final String id;
  // final String productId;
  // final double price;
  // final int quantity;
  // final String title;
  // final String imageUrl;
  //
  // const CartFull({required this.id, required this.productId,
  //   required this.price, required this.quantity, required this.title,
  //   required this.imageUrl});

  // final String productId;
  //
  // const OrderFull({required this.productId});

  @override
  _OrderFullState createState() => _OrderFullState();
}

class _OrderFullState extends State<OrderFull> {


  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final orderAttr = Provider.of<OrderAttr>(context);


    GlobalMethods globalMethods = GlobalMethods();
    bool _isLoading = false;

    return InkWell(
      onTap: ()=> Navigator.pushNamed(context, ProductDetailScreen.routeName,
          arguments: orderAttr.productId),
      child: Container(
        height: 160,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
          ),
          color: Theme.of(context).backgroundColor,
        ),
        child: Row(
          children: [
            Container(
              width: 130,
              decoration: BoxDecoration(image: DecorationImage(
                image: NetworkImage(orderAttr.imageUrl),
                  fit: BoxFit.contain
              )),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: Text(orderAttr.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15
                        ),),
                      ),
                      Material(
                        color:Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16.0),
                          onTap: (){
                            globalMethods.showDialogg('Remove Order',
                              'Order will be deleted!'
                              , () async{
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await FirebaseFirestore.instance
                                      .collection('order')
                                      .doc(orderAttr.orderId)
                                      .delete();
                                },
                              context
                            );
                            Navigator.pop(context);
                          },
                          child: Container(
                              height: 50,
                              width: 50,
                              child: _isLoading
                                  ? CircularProgressIndicator()
                                  :Icon(Icons.close,
                                    color: Colors.red,
                                    size: 20
                                  ),
                        ),
                      ),
                    ),
                    ],
                  ),
                  Row(children: [
                    Text('Price : '),
                    SizedBox(width: 10,),
                    Text(orderAttr.price,style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      // color: themeChange.darkTheme
                      //     ? Colors.brown.shade900
                      //     : Theme.of(context).primaryColor
                    ))
                  ],),
                  Row(children: [
                    Text('Quantity : '),
                    SizedBox(width: 10,),
                    Text(orderAttr.quantity,style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        // color: themeChange.darkTheme
                        //     ? Colors.brown.shade900
                        //     : Theme.of(context).primaryColor
                    ))
                  ],),
                  Row(children: [
                    Flexible(child: Text('Order-ID: ')),
                    SizedBox(width: 10,),
                    Flexible(child: Text(orderAttr.orderId,style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        // color: themeChange.darkTheme
                        //     ? Colors.brown.shade900
                        //     : Theme.of(context).primaryColor
                    )),
                    ),
                  ],),

                ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
