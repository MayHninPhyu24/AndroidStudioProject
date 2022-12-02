import 'package:ecommerence/consts/theme_data.dart';
import 'package:ecommerence/inner_screens/brands_navigation_rail.dart';
import 'package:ecommerence/models/product.dart';
import 'package:ecommerence/provider/brand_provider.dart';
import 'package:ecommerence/provider/cart_provider.dart';
import 'package:ecommerence/provider/category_provider.dart';
import 'package:ecommerence/provider/dark_theme_provider.dart';
import 'package:ecommerence/provider/fav_provider.dart';
import 'package:ecommerence/provider/order_provider.dart';
import 'package:ecommerence/provider/product_provider.dart';
import 'package:ecommerence/screens/auth/forget_password.dart';
import 'package:ecommerence/screens/auth/login.dart';
import 'package:ecommerence/screens/auth/sign_up.dart';
import 'package:ecommerence/screens/bottom_bar.dart';
import 'package:ecommerence/screens/cart/cart.dart';
import 'package:ecommerence/screens/category_feeds.dart';
import 'package:ecommerence/screens/feeds.dart';
import 'package:ecommerence/inner_screens/product_detail.dart';
import 'package:ecommerence/screens/order/order.dart';
import 'package:ecommerence/screens/upload_brand_form.dart';
import 'package:ecommerence/screens/upload_category_form.dart';
import 'package:ecommerence/screens/user_state.dart';
import 'package:ecommerence/screens/wishlist/wishlist.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

import 'screens/upload_product_form.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = 'pk_test_31ag3NGjwmfNKUeZkD6aIsPB';
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme = await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    // TODO: implement initState
    getCurrentAppTheme();
    super.initState();

  }
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: _initialization,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return MaterialApp(
              home: Scaffold(body: Center(
                child: CircularProgressIndicator(),
              ),),
            );
          }else if( snapshot.hasError){
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('Error Occured'),
                ),
              ),
            );
          }
          return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) {
                  return themeChangeProvider;
                }),
                ChangeNotifierProvider(
                  create: (_) => ProductProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => CategoryProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => BrandProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => CartProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => FavProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => OrderProvider(),
                ),
              ],
              child:
              Consumer<DarkThemeProvider>(builder: (context, themeData, child) {
                return MaterialApp(
                  title: 'Flutter Demo',
                  theme: Styles.themeData(themeChangeProvider.darkTheme, context),
                  // home: LandingScreen(),
                  home: UserState(),
                  routes: {
                    // '/': (context) => BottomBarScreen(), //CategoriesScreen
                    BrandNavigationRailScreen.routeName: (context) => BrandNavigationRailScreen(),
                    FeedsScreen.routeName: (context) => FeedsScreen(),
                    CartScreen.routeName: (context) => CartScreen(),
                    OrderScreen.routeName: (context) => OrderScreen(),
                    WishlistScreen.routeName: (context) => WishlistScreen(),
                    ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
                    CategoryFeedsScreen.routeName: (context) => CategoryFeedsScreen(),
                    LoginScreen.routeName: (context) => LoginScreen(),
                    SignUpScreen.routeName: (context) => SignUpScreen(),
                    BottomBarScreen.routeName: (context) => BottomBarScreen(),
                    UploadProductForm.routeName: (context) => UploadProductForm(),
                    UploadCategoryForm.routeName: (context) => UploadProductForm(),
                    UploadBrandForm.routeName: (context) => UploadBrandForm(),
                    ForgetPassword.routeName: (context) => ForgetPassword(),
                  },
                );
              }));
        }
    );
  }
}

