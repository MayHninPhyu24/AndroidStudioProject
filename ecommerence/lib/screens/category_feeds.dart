import 'package:ecommerence/models/product.dart';
import 'package:ecommerence/provider/product_provider.dart';
import 'package:ecommerence/widget/feeds_product.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:provider/provider.dart';


class CategoryFeedsScreen extends StatelessWidget {
  static const routeName = '/CategoryFeedsScreen';

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    final categoryName = ModalRoute.of(context)!.settings.arguments as String;
    List<Product> productLists = productProvider.findByCategory(categoryName);


    return Scaffold(
      body: productLists.isEmpty
      ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Icon(Typicons.database,size: 80,)),
            SizedBox(height: 40,),
            Center(
              child: Text('No products relatd to this brand',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22
                ),
              ),
            ),
          ],
        ),
      )
      : GridView.count(crossAxisCount: 2,
        childAspectRatio: 240/450,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: List.generate(productLists.length, (index) {
          return ChangeNotifierProvider.value(
            value: productLists[index],
            child: FeedProducts(

            ),
          );
        }),),
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
