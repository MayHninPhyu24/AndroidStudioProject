import 'package:ecommerence/consts/colors.dart';
import 'package:ecommerence/consts/my_icons.dart';
import 'package:ecommerence/inner_screens/product_detail.dart';
import 'package:ecommerence/models/product.dart';
import 'package:ecommerence/provider/cart_provider.dart';
import 'package:ecommerence/provider/fav_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:provider/provider.dart';

class PopularProducts extends StatelessWidget {
  // final String imageUrl;
  // final String title;
  // final double price;
  // final String description;
  //
  // PopularProducts({required this.imageUrl, required this.title,
  //   required this.price, required this.description});

  @override
  Widget build(BuildContext context) {
    final productAttribute = Provider.of<Product>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final favProvider = Provider.of<FavProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
              10.0,
            ),
            bottomRight: Radius.circular(10.0
            ),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(
                10.0,
              ),
              bottomRight: Radius.circular(10.0
              ),
            ),
            onTap: () => Navigator.pushNamed(context, ProductDetailScreen.routeName,
            arguments: productAttribute.id),
            child: Column(children: [
              Stack(children: [
                Container(
                    height: 170,
                    decoration: BoxDecoration(image: DecorationImage(
                  image: NetworkImage(productAttribute.imageUrl),
                  fit: BoxFit.contain
                ))),
                Positioned(
                    right: 10,
                    top: 8,
                    child: InkWell(
                      splashColor: ColorsConsts.favColor,
                      onTap: (){
                        favProvider.addAndRemoveFromFav(productAttribute.id,
                            productAttribute.price, productAttribute.title,
                            productAttribute.imageUrl);
                      },
                      child: Icon(
                        favProvider.favItems.containsKey(productAttribute.id)
                            ? Icons.favorite: MyAppIcons.wishlist,
                        color: favProvider.favItems.containsKey(productAttribute.id)
                            ?Colors.red: ColorsConsts.black,
                ),
                    )),
                // Positioned(
                //     right: 10,
                //     top: 8,
                //     child: Icon(
                //       Typicons.star_filled, color: Colors.white,
                //     )),
                Positioned(
                    right: 12,
                    bottom: 32.0,
                    child: Container(
                  padding: EdgeInsets.all(10.0),
                      color: Theme.of(context).backgroundColor,
                      child: Text(
                        '\$ ${productAttribute.price}',
                        style: TextStyle(
                          color: Theme.of(context).textSelectionColor
                        ),
                      ),
                ))
              ],),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(productAttribute.title,
                    maxLines: 1,
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Row(children: [
                      Expanded(
                        flex: 3,
                        child: Text(productAttribute.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 15.0,
                              fontWeight: FontWeight.w500, color: Colors.grey[800]),
                        ),
                      ),
                      Spacer(),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: (){
                            cartProvider.CartItems.containsKey(productAttribute.id)
                                ?(){}
                                :cartProvider.addProductToCart(
                                productAttribute.id,
                                productAttribute.price,
                                productAttribute.title,
                                productAttribute.imageUrl);
                          },
                          borderRadius: BorderRadius.circular(30.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              cartProvider.CartItems.containsKey(productAttribute.id)
                                  ?MyAppIcons.checked:MyAppIcons.cart_plus,
                                size: 25,
                                color: Colors.black,
                            ),
                          ),
                        ),)
                    ],)
                  ],
                ),
              )
            ],),
          ),
        ),
      ),
    );
  }
}
