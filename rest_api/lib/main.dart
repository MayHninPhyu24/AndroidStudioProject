import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/auth_screen.dart';
import 'package:untitled1/model/product_attr.dart';
import 'package:untitled1/product_detail.dart';
import 'package:untitled1/provider/product_provider.dart';
import 'package:untitled1/splash_screen.dart';
import 'package:untitled1/update_product.dart';
import 'add_product.dart';
import 'provider/auth_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<AuthProvider>(
        create: (_) => AuthProvider(),
      ),
      ChangeNotifierProxyProvider<AuthProvider, ProductProvider>(
        create: (_) => ProductProvider(),
        update: (ctx, value, previousProductProvider) =>
        previousProductProvider!
          ..getData(
             value.token,
             previousProductProvider.productList
           ),
      ),
    ],
    child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (ctx, value, _) => MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.orange,
          canvasColor: const Color.fromRGBO(255, 238, 219, 1)
        ),
        debugShowCheckedModeBanner: false,
        home: value.isAuth
            ? MyHomePage()
            : FutureBuilder(
            future: value.tryAutoLogin(),
            builder: (ctx, snapShot)=>
                snapShot.connectionState == ConnectionState.waiting
                ? SplashScreen()
                : AuthScreen()),
        routes: {
          ProductDetail.routeName: (context) =>
              ProductDetail(),
          UpdateProduct.routeName: (context) =>
              UpdateProduct(),
        }
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = true;

  @override
  void initState() {
    Provider.of<ProductProvider>(context, listen: false)
        .fetchData()
        .catchError((onError) => print(onError));
    setState(() {
      _isLoading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<ProductAttr> productList = Provider.of<ProductProvider>(context,listen: true).productList;
    print(productList);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
        actions: [
          FlatButton(
              onPressed: (){
                Provider.of<AuthProvider>(context, listen: false).logout();
              },
              child: const Text('Logout')),
        ],
      ),
      body:
      _isLoading
        ? const Center(child: CircularProgressIndicator())
        : (productList.isEmpty
          ? const Center(
              child: Text('No Products Added.', style: const TextStyle(fontSize: 22),),
            )
          : RefreshIndicator(
            onRefresh: () async => await Provider.of<ProductProvider>(context, listen: false).fetchData(),
            child: ListView(
                children: productList.map((item) => Builder(
                    builder: (ctx)=> detailCard(
                        item.id,
                        item.title,
                        item.description,
                        item.price,
                        item.imageUrl,
                    ))).toList(),
              ),
          )),
      floatingActionButton: Container(
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Theme.of(context).primaryColor,
        ),
        child: FlatButton.icon(
          label: const Text("Add Product",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
          icon: const Icon(Icons.add),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddProduct())),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Widget detailCard(id, tile, desc, price, imageUrl) {
    return Builder(
      builder: (innerContext) => FlatButton(
        onPressed: () {
          // print(id);
          Navigator.pushNamed(context, ProductDetail.routeName,
              arguments: id
          );

          // Navigator.push(
          //   innerContext,
          //   MaterialPageRoute(builder: (_) => ProductDetail(id)),
          // ).then(
          //         (id) => Provider.of<ProductProvider>(context, listen: false).delete(id));
        },
        child: Column(
          children: [
            const SizedBox(height: 5),
            Card(
              elevation: 10,
              color: const Color.fromRGBO(115, 138, 119, 1),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      width: 130,
                      child: Hero(
                        tag: id,
                        child: Image.network(imageUrl),
                        // child: Image.network(imageUrl, fit: BoxFit.fill),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 10),
                        Text(
                          tile,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const Divider(color: Colors.white),
                        Container(
                          width: 200,
                          child: Text(
                            desc,
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.justify,
                            maxLines: 3,
                          ),
                        ),
                        const Divider(color: Colors.white),
                        Text(
                          "\$$price",
                          style: const TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        const SizedBox(height: 13),
                      ],
                    ),
                  ),
                  const Expanded(flex: 1, child: Icon(Icons.arrow_forward_ios)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
