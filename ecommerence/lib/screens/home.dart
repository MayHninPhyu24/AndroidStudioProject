import 'package:backdrop/backdrop.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerence/consts/colors.dart';
import 'package:ecommerence/inner_screens/brands_navigation_rail.dart';
import 'package:ecommerence/models/brand_attr.dart';
import 'package:ecommerence/models/category_attr.dart';
import 'package:ecommerence/models/product.dart';
import 'package:ecommerence/provider/brand_provider.dart';
import 'package:ecommerence/provider/category_provider.dart';
import 'package:ecommerence/provider/order_provider.dart';
import 'package:ecommerence/provider/product_provider.dart';
import 'package:ecommerence/screens/feeds.dart';
import 'package:ecommerence/screens/user_info.dart';
import 'package:ecommerence/widget/backlayer.dart';
import 'package:ecommerence/widget/category.dart';
import 'package:ecommerence/widget/popular_products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:fluttericon/brandico_icons.dart';
import 'package:provider/provider.dart';

final List<String> imgList = [
  'assets/images/carousel1.png',
  'assets/images/carousel2.jpeg',
  'assets/images/carousel3.jpg',
  'assets/images/carousel4.png',
  ];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
  child: Container(
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.asset(item),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Text(
                  'No. ${imgList.indexOf(item)} image',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        )),
  ),
))
    .toList();

List brandImages = [
  'assets/images/addidas.jpg',
  'assets/images/apple.jpg',
  'assets/images/dell.jpg',
  'assets/images/h&m.jpg',
  'assets/images/nike.jpg',
  'assets/images/samsung.jpg',
  'assets/images/huawei.jpg',
];



class HomeScreen extends StatefulWidget {


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _userImageUrl;
  String? _uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  void getData() async{
    User user = _auth.currentUser!;
    _uid = user.uid;
    final  DocumentSnapshot<Map<String, dynamic>>? userDoc = user.isAnonymous
        ? null
        : await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if(userDoc != null){
      setState(() {
        _userImageUrl = userDoc.get('imageUrl');
      });
    }else{
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    productData.fetchProducts();
    List<Product> popularProduct = productData.popularProducts;

    final categoryProvider = Provider.of<CategoryProvider>(context);
    categoryProvider.fetchCategory();
    List<CategoryAttr> categoryLists = categoryProvider.categories;

    final brandProvider = Provider.of<BrandProvider>(context);
    brandProvider.fetchBrand();
    List<BrandAttr> brandLists = brandProvider.brands;

    return BackdropScaffold(
      frontLayerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      headerHeight: MediaQuery.of(context).size.height * 0.25,
      appBar: BackdropAppBar(
        title: Text("Home"),
        leading: BackdropToggleButton(
          icon: AnimatedIcons.menu_home,
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorsConsts.starterColor,
                ColorsConsts.endColor
              ]
            )
          ),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: (){},
              iconSize:15,
              icon: CircleAvatar(radius: 15,
              backgroundColor: Colors.white,
              backgroundImage:  NetworkImage(_userImageUrl ??
                  'https://t3.ftcdn.net/jpg/01/83/55/76/240_F_183557656_DRcvOesmfDl5BIyhPKrcWANFKy2964i9.jpg'),
              ),
          )
        ],
      ),
      backLayer: BackLayerMenu(_userImageUrl),
      frontLayer: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
            width: double.infinity,
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
              items: imageSliders,
            ),
          ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Text('Categories',
                  style: TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 20),),
              ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 180,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryLists.length,
                  itemBuilder: (BuildContext ctx, int index){
                    return ChangeNotifierProvider.value(
                      value: categoryLists[index],
                      child: CategoryWidget(),
                    );
                  }),
              // child: ListView.builder(
              //   scrollDirection: Axis.horizontal,
              //   itemBuilder: (BuildContext ctx, int index){
              //     return CategoryWidget(index: index);
              //   },
              //   itemCount: 7,
              // ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Text('Popular Brands',
                  style: TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 20),),
                Spacer(),
                FlatButton(onPressed: (){
                  Navigator.of(context).pushNamed(
                    BrandNavigationRailScreen.routeName,
                    arguments: {
                      7,
                    },
                  );
                },
                    child: Text(
                      'View All...',
                      style: TextStyle(fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: Colors.red
                      ),
                    ))
              ],
              ),
            ),
            Container(
              height: 210,
              width: MediaQuery.of(context).size.width * 0.95,
              child: Swiper(
                itemCount: brandLists.length,
                autoplay: true,
                viewportFraction: 0.8,
                scale: 0.9,
                onTap: (index){
                  Navigator.of(context).pushNamed(
                    BrandNavigationRailScreen.routeName,
                    arguments: {
                      index,
                    },
                  );
                },
                itemBuilder: (BuildContext ctx, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(brandLists[index].imageUrl as String),
                            fit: BoxFit.cover
                        ),
                      ),
                      // child: Image.asset(brandImages[index], fit: BoxFit.fill,),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Text('Popular Products',
                  style: TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 20),),
                Spacer(),
                FlatButton(onPressed: (){
                  Navigator.of(context).pushNamed(FeedsScreen.routeName,
                  arguments: "popular"
                  );
                },
                    child: Text(
                      'View All...',
                      style: TextStyle(fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: Colors.red
                      ),
                    )),
              ],
              ),
            ),
            Container(width:double.infinity,
              height: 285,
              margin: EdgeInsets.symmetric(horizontal: 3),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: popularProduct.length,
                  itemBuilder: (BuildContext ctx, int index){
                    return ChangeNotifierProvider.value(
                      value: popularProduct[index],
                      child: PopularProducts(),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
