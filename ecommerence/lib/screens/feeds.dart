import 'package:badges/badges.dart';
import 'package:ecommerence/consts/colors.dart';
import 'package:ecommerence/consts/my_icons.dart';
import 'package:ecommerence/models/product.dart';
import 'package:ecommerence/provider/cart_provider.dart';
import 'package:ecommerence/provider/fav_provider.dart';
import 'package:ecommerence/provider/product_provider.dart';
import 'package:ecommerence/screens/cart/cart.dart';
import 'package:ecommerence/screens/wishlist/wishlist.dart';
import 'package:ecommerence/widget/feeds_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class FeedsScreen extends StatefulWidget {
  static const routeName = '/FeedsScreen';

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  Future<void> _getProductOnRefresh()async {
     await Provider.of<ProductProvider>(context, listen: false).fetchProducts();
     setState(() {

     });
  }

  @override
  Widget build(BuildContext context){


    final productProvider = Provider.of<ProductProvider>(context);
    List<Product> productLists = productProvider.products;
    final Object? popular = ModalRoute.of(context)?.settings.arguments ?? null;

    if(popular != null && popular == 'popular'){
      productLists = productProvider.popularProducts;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Feeds'),
        backgroundColor: Theme.of(context).cardColor,
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
      body: RefreshIndicator(
        onRefresh: _getProductOnRefresh,
        child: GridView.count(crossAxisCount: 2,
          childAspectRatio: 240/450,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: List.generate(productLists.length, (index) {
            return ChangeNotifierProvider.value(
              value: productLists[index],
              child: FeedProducts(),
            );
          }),),
      ),
    );
      // StaggeredGridView.countBuilder(
      //   crossAxisCount: 4,
      //   mainAxisSpacing: 4,
      //   crossAxisSpacing: 4,
      //   itemBuilder: (BuildContext context, int index) => FeedProducts(),
      //   staggeredTileBuilder: (int index) => new StaggeredTile.count(2,index.isEven ? 2 : 1),
      //   padding: const EdgeInsets.all(4),
      // ));


  }
}
