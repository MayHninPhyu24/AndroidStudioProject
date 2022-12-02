import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerence/consts/colors.dart';
import 'package:ecommerence/consts/my_icons.dart';
import 'package:ecommerence/provider/cart_provider.dart';
import 'package:ecommerence/provider/dark_theme_provider.dart';
import 'package:ecommerence/provider/fav_provider.dart';
import 'package:ecommerence/provider/product_provider.dart';
import 'package:ecommerence/screens/cart/cart.dart';
import 'package:ecommerence/screens/order/order.dart';
import 'package:ecommerence/screens/wishlist/wishlist.dart';
import 'package:ecommerence/widget/feeds_product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/ProductDetailScreen';

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final productData = Provider.of<ProductProvider>(context, listen: false);
    final productLists = productData.products; // Suggested Product

    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final productDetail = productData.findById(productId);

    final cartProvider = Provider.of<CartProvider>(context);
    final favProvider = Provider.of<FavProvider>(context);


    return Scaffold(
      body: Stack(
        children: [
            Container(
              foregroundDecoration: BoxDecoration(color: Colors.black12),
              height: MediaQuery.of(context).size.height * 0.45,
              width: double.infinity,
              child: Image.network(
                productDetail.imageUrl,
              ),
            ),
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 16.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height:250),
                Padding(padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.purple.shade200,
                        onTap: (){},
                        borderRadius: BorderRadius.circular(30),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.save,
                            size: 23,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.purple.shade200,
                        onTap: (){},
                        borderRadius: BorderRadius.circular(30),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.share,
                            size: 23,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ),
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Text(
                                productDetail.title,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height:8
                            ),
                            Text('US \$ ${productDetail.price}',
                            style: TextStyle(
                              color: themeState.darkTheme
                                  ? Theme.of(context).disabledColor
                                  : ColorsConsts.subTitle,
                              fontWeight: FontWeight.bold,
                              fontSize: 21.0
                            ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height:3.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(
                          thickness: 1,
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Padding(padding: EdgeInsets.all(16.0),
                      child: Text(
                        productDetail.description,
                        style: TextStyle(
                            color: themeState.darkTheme
                                ? Theme.of(context).disabledColor
                                : ColorsConsts.subTitle,
                            fontWeight: FontWeight.w400,
                            fontSize: 21.0
                        ),
                      ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                        height: 1,
                      ),
                      ),
                      _details(themeState.darkTheme, 'Brand: ', productDetail.brand,context),
                      _details(themeState.darkTheme, 'Quantity: ', '${productDetail.quantity} Left',
                          context),
                      _details(themeState.darkTheme, 'Category: ', productDetail.productCategoryName,
                          context),
                      _details(themeState.darkTheme, 'Popularity: ',
                          productDetail.isPopular ? 'Popular':'Barely Known', context),
                      SizedBox(
                        height: 15,
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey,
                        height: 1,
                      ),

                      Container(
                        color: Theme.of(context).backgroundColor,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 10.0,),
                            Padding(padding: EdgeInsets.all(8.0),
                            child: Text(
                              'No reviews yet',
                              style: TextStyle(
                                  color: Theme.of(context).textSelectionColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 21.0
                              ),
                            ),
                            ),
                            Padding(padding: EdgeInsets.all(2.0),
                              child: Text(
                                'Be the first review!',
                                style: TextStyle(
                                    color: themeState.darkTheme
                                        ? Theme.of(context).disabledColor
                                        : ColorsConsts.subTitle,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20.0
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 70,
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                              height: 1,
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8.0),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Text(
                    'Suggested Products:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  width: double.infinity,
                  height: 400,
                  child: ListView.builder(
                      itemCount: productLists.length < 7
                          ? productLists.length: 7,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext ctx, int index){
                    return ChangeNotifierProvider.value(
                        value: productLists[index],
                        child:FeedProducts());
                  }),
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Detail',
                style: TextStyle(
                  fontSize: 16.0, fontWeight: FontWeight.normal
                ),
              ),
              actions: [
                Consumer<FavProvider>(
                  builder: (_, favs, ch)=> Badge(
                    badgeColor: ColorsConsts.cartBadgeColor,
                    animationType: BadgeAnimationType.slide,
                    toAnimate: true,
                    position: BadgePosition.topEnd(top: 5, end: 7),
                    badgeContent: Text(favs.favItems.length.toString()),
                    child: IconButton(onPressed: (){
                      Navigator.of(context).pushNamed(WishlistScreen.routeName);
                    },
                        icon: Icon(MyAppIcons.wishlist,
                        color: ColorsConsts.favColor,),
                    ),
                  ),
                ),
                Consumer<CartProvider>(
                  builder: (_, cart, ch)=> Badge(
                    badgeColor: ColorsConsts.cartBadgeColor,
                    animationType: BadgeAnimationType.slide,
                    toAnimate: true,
                    position: BadgePosition.topEnd(top: 5, end: 7),
                    badgeContent: Text(cart.CartItems.length.toString()),
                    child: IconButton(onPressed: (){
                      Navigator.of(context).pushNamed(CartScreen.routeName);
                    }, icon: Icon(MyAppIcons.cart, color: ColorsConsts.cartColor))
                  ),
                ),

              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              children: [
                Expanded(
                    flex : 3,
                    child: Container(
                    height: 50,
                      child: RaisedButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(side:  BorderSide.none),
                        color: Colors.redAccent.shade400,
                        onPressed: (){
                          cartProvider.CartItems.containsKey(productId)
                              ?(){}
                              :cartProvider.addProductToCart(productDetail.id,
                              productDetail.price, productDetail.title,
                              productDetail.imageUrl);
                        },
                        child: Text(
                            cartProvider.CartItems.containsKey(productId)
                                ?'In Cart'
                                :'Add To Cart'.toUpperCase(),
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                ),
                ),
                Expanded(
                  flex : 2,
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(side:  BorderSide.none),
                      color: Theme.of(context).backgroundColor,
                      onPressed: (){},
                      child: Row(
                        children:[
                          Text(
                            'Buy Now'.toUpperCase(),
                            style: TextStyle(fontSize: 14,
                                color: Theme.of(context).textSelectionColor),
                          ),
                          SizedBox(width: 5,),
                          Icon(
                            Icons.payment,
                            color: Colors.green.shade700,
                            size: 19,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: themeState.darkTheme
                        ? Theme.of(context).disabledColor
                        : ColorsConsts.subTitle,
                    height: 50,
                    child: InkWell(
                      splashColor: ColorsConsts.favColor,
                      onTap: (){
                        favProvider.addAndRemoveFromFav(productId,
                            productDetail.price, productDetail.title,
                            productDetail.imageUrl);
                      },
                      child: Center(
                        child: Icon(
                          favProvider.favItems.containsKey(productId)
                              ? Icons.favorite: MyAppIcons.wishlist,
                          color: favProvider.favItems.containsKey(productId)
                              ?Colors.red: ColorsConsts.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _details(bool themeState, String title, String info, BuildContext ctx) {
    return Padding(padding: EdgeInsets.only(top: 15, left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(
            color: Theme.of(ctx).textSelectionColor,
            fontWeight: FontWeight.w400,
            fontSize: 21.0
          ),),
          Text(info, style: TextStyle(
              color: themeState
              ? Theme.of(ctx).disabledColor
              : ColorsConsts.subTitle,
          ),),
        ],
      ),
    );
  }
}
