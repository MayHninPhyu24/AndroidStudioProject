import 'package:ecommerence/consts/colors.dart';
import 'package:ecommerence/inner_screens/product_detail.dart';
import 'package:ecommerence/models/cart_attr.dart';
import 'package:ecommerence/provider/cart_provider.dart';
import 'package:ecommerence/provider/dark_theme_provider.dart';
import 'package:ecommerence/services/global_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttericon/zocial_icons.dart';
import 'package:provider/provider.dart';

class CartFull extends StatefulWidget {
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

  final String productId;

  const CartFull({required this.productId});

  @override
  _CartFullState createState() => _CartFullState();
}

class _CartFullState extends State<CartFull> {


  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final cartAttr = Provider.of<CartAttr>(context);
    double subTotal = cartAttr.price * cartAttr.quantity;

    final cartProvider = Provider.of<CartProvider>(context);

    GlobalMethods globalMethods = GlobalMethods();


    return InkWell(
      onTap: () => Navigator.pushNamed(context, ProductDetailScreen.routeName,
          arguments: widget.productId),
      child: Container(
        height: 135,
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
                image: NetworkImage(cartAttr.imageUrl),
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
                      Flexible(child: Text(cartAttr.title,
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
                            globalMethods.showDialogg('Remove Item',
                              'Product will be removed from the cart'
                              , ()=>cartProvider.removeItem(widget.productId),
                              context
                            );
                          },
                          child: Container(
                              height: 50,
                              width: 50,
                              child:Icon(Icons.close,
                                color: Colors.red,
                                size: 20
                              ),
                        ),
                      ),
                    ),
                    ],
                  ),
                  Row(children: [
                    Text('Price'),
                    SizedBox(width: 5,),
                    Text('${cartAttr.price}',style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: themeChange.darkTheme
                          ? Colors.brown.shade900
                          : Theme.of(context).primaryColor))
                  ],),
                  Row(children: [
                    Text('Sub Total'),
                    SizedBox(width: 5,),
                    FittedBox(
                      child: Text('${subTotal.toStringAsFixed(2)} \$',style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: themeChange.darkTheme
                              ? Colors.brown.shade900
                              : Theme.of(context).accentColor)),
                    )
                  ],),
                  Row(children: [
                    Text('Ships Free', style: TextStyle(
                        color: themeChange.darkTheme
                        ? Colors.brown.shade900
                        : Theme.of(context).accentColor)),
                    Spacer(),
                    Material(
                      color:Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16.0),
                        onTap: cartAttr.quantity< 2 ? null:(){
                          cartProvider.reduceCartByOne(
                              widget.productId);
                          },
                        child: Container(
                          child:Icon(Typicons.minus,
                              color: cartAttr.quantity< 2 ? Colors.grey:Colors.red,
                              size: 18
                          ),
                        ),
                      ),
                    ),
                    Card(elevation: 12,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      padding: EdgeInsets.all(8.0),
                      decoration:BoxDecoration(gradient:LinearGradient(
                        colors: [
                          ColorsConsts.gradientLStart,
                          ColorsConsts.gradientLEnd
                        ], stops: [
                        0.0,
                        0.7
                      ],
                      )),
                      child: Text('${cartAttr.quantity}', textAlign: TextAlign.center,)
                    ),
                    ),
                    Material(
                      color:Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16.0),
                        onTap: (){
                          cartProvider.addProductToCart(widget.productId,
                              cartAttr.price, cartAttr.title,
                              cartAttr.imageUrl);
                        },
                        child: Container(
                          child:Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(Icons.add,
                                color: Colors.green,
                                size: 22
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],)
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
