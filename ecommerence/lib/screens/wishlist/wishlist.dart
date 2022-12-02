import 'package:ecommerence/consts/my_icons.dart';
import 'package:ecommerence/provider/fav_provider.dart';
import 'package:ecommerence/screens/wishlist/wishlist_empty.dart';
import 'package:ecommerence/services/global_method.dart';
import 'package:ecommerence/screens/wishlist/wishlist_full.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = '/WishlistScreen';
  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavProvider>(context);
    GlobalMethods globalMethods = GlobalMethods();


    return favProvider.favItems.isEmpty
        ? Scaffold(body: WishlistEmpty())
        : Scaffold(
      appBar: AppBar(
        title: Text('Wishlist (${favProvider.favItems.length})'),
        actions: [
          IconButton(onPressed: (){
            globalMethods.showDialogg('Clear Wish',
                "Your wishlist will be cleared",
                favProvider.clearFav,
                context
            );
          }, icon: Icon(MyAppIcons.trash))
        ],
      ),
      body: ListView.builder(
        itemCount: favProvider.favItems.length,
        itemBuilder: (BuildContext ctx, int index) {
          return ChangeNotifierProvider.value(
              value: favProvider.favItems.values.toList()[index],
              child: WishlistFull(
                productId: favProvider.favItems.keys.toList()[index],
              ));
        },
      ),
    );
  }
}
