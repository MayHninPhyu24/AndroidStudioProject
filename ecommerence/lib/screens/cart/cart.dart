import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerence/consts/colors.dart';
import 'package:ecommerence/consts/my_icons.dart';
import 'package:ecommerence/models/cart_attr.dart';
import 'package:ecommerence/provider/cart_provider.dart';
import 'package:ecommerence/screens/order/order.dart';
import 'package:ecommerence/services/global_method.dart';
import 'package:ecommerence/screens/cart/cart_full.dart';
import 'package:ecommerence/services/payment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:uuid/uuid.dart';

import 'cart_empty.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/CartScreen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void payWithCard(int amount) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(max: 100, msg: 'Please wait...');
    var response = await StripeService.makePayment(
        amount.toString(), 'USD');
    pd.close();
    print('response : ${response?.message}');
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(response!.message),
      duration: Duration(milliseconds: 1200),
      // duration: Duration(milliseconds: response!.success == true ? 1200 : 3000),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    Map<String, CartAttr> cartLists = cartProvider.CartItems;
    GlobalMethods globalMethods = GlobalMethods();
    print(cartProvider.CartItems.isEmpty);
    return cartProvider.CartItems.isEmpty? Scaffold(
      body: CartEmpty(),
    ): Scaffold(
      bottomSheet: checkoutSection(context, cartProvider.totalAmount),
      appBar: AppBar(
        title: Text('Cart (${cartProvider.CartItems.length})'),
        // backgroundColor: Theme.of(context).backgroundColor,
        actions: [
          IconButton(onPressed: (){
            globalMethods.showDialogg('Clear Cart', "Your cart will be cleared",
                cartProvider.clearCart,
                context
            );
          }, icon: Icon(MyAppIcons.trash))
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: 60),
        child: ListView.builder(itemCount: cartProvider.CartItems.length,
            itemBuilder: (BuildContext ctx, int index){
          return ChangeNotifierProvider.value(
            value: cartLists.values.toList()[index],
            child: CartFull(
              productId: cartProvider.CartItems.keys.toList()[index],
            ),
          );
        }),
      ),
    );
  }

  Widget checkoutSection (BuildContext ctx, double subtotal) {
    final uuid = Uuid();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    String? _uid;
    final cartProvider = Provider.of<CartProvider>(ctx);
    return Container(
      decoration: BoxDecoration(
        border:Border(top: BorderSide(color: Colors.grey, width: 0.5))
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient:LinearGradient(
                colors: [
                  ColorsConsts.gradientLStart,
                  ColorsConsts.gradientLEnd
                ], stops: [
                0.0,
                0.7
              ],
              )),
              child: Material(
                borderRadius: BorderRadius.circular(30),
                color: Colors.red,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    // double amountInCents = subtotal * 1000;
                    // int integerAmount = (amountInCents / 10).ceil();
                    // payWithCard(integerAmount);

                    User user = _auth.currentUser!;
                    _uid = user.uid;
                    cartProvider.CartItems.forEach((key, orderValue)
                    async{
                      final orderId = uuid.v4();
                     try{
                       showDialog(
                           context: context,
                           builder: (BuildContext ctx) {
                             return AlertDialog(
                               title: Row(
                                 children: [
                                   Padding(
                                     padding: const EdgeInsets.only(right: 6.0),
                                     child: Image.network(
                                       'https://image.flaticon.com/icons/png/128/564/564619.png',
                                       height: 20,
                                       width: 20,
                                     ),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Text('Check Out'),
                                   ),
                                 ],
                               ),
                               content: Text('Do you want to checkout?'),
                               actions: [
                                 TextButton(
                                     onPressed: () => Navigator.pop(context),
                                     child: Text('Cancel')),
                                 TextButton(
                                     onPressed: () async{
                                       await FirebaseFirestore.instance
                                           .collection('order')
                                           .doc(orderId)
                                           .set({
                                         'order_id': orderId,
                                         'user_id': _uid,
                                         'product_id': orderValue.productId,
                                         'title': orderValue.title,
                                         'price': orderValue.price * orderValue.quantity,
                                         'imageUrl': orderValue.imageUrl,
                                         'quantity': orderValue.quantity,
                                         'orderDate': Timestamp.now(),
                                       });
                                       cartProvider.clearCart();
                                       Navigator.pop(context);
                                       Navigator.pushNamed(context, OrderScreen.routeName);
                                     },
                                     child: Text('ok')),
                               ],
                             );
                           });


                     }catch(err){
                       print('Error occur $err');
                     }
                    });

                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Checkout',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Theme.of(ctx).textSelectionColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),),
                  ),
                ),
              ),
            ),
          ),
          Spacer(),
          Text('Total ',
            style: TextStyle(color: Theme.of(ctx).textSelectionColor,
                fontSize: 18,
                fontWeight: FontWeight.w600),),
          Text('US \$ ${subtotal.toStringAsFixed(3)}',
            style: TextStyle(color: Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.w600),),
        ],),
      ),
    );
  }
}
