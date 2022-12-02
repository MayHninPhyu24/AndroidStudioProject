import 'package:ecommerence/consts/colors.dart';
import 'package:ecommerence/consts/my_icons.dart';
import 'package:ecommerence/models/cart_attr.dart';
import 'package:ecommerence/provider/cart_provider.dart';
import 'package:ecommerence/provider/order_provider.dart';
import 'package:ecommerence/screens/order/order_full.dart';
import 'package:ecommerence/services/global_method.dart';
import 'package:ecommerence/screens/cart/cart_full.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'order_empty.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/OrderScreen';

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    return FutureBuilder(
      future: orderProvider.fetchOrders(),
      builder: (context, snapshot){
        return orderProvider.getOrders.isEmpty
            ? Scaffold(body: OrderEmpty(),)
            : Scaffold(
              appBar: AppBar(
                title: Text('Order (${orderProvider.getOrders.length})'),
                // backgroundColor: Theme.of(context).backgroundColor,
                actions: [
                  IconButton(onPressed: (){
                    // globalMethods.showDialogg('Clear Cart', "Your cart will be cleared",
                    //     cartProvider.clearCart,
                    //     context
                    // );
                  }, icon: Icon(MyAppIcons.trash))
                ],
              ),
              body: Container(
                    margin: EdgeInsets.only(bottom: 60),
                    child: ListView.builder(
                        itemCount: orderProvider.getOrders.length,
                        itemBuilder: (BuildContext ctx, int index){
                          return ChangeNotifierProvider.value(
                              value: orderProvider.getOrders[index],
                              child: OrderFull());
                        }),
              ),
            );
      }
    );
  }
}
