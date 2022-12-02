import 'package:ecommerence/consts/my_icons.dart';
import 'package:ecommerence/screens/cart/cart.dart';
import 'package:ecommerence/screens/feeds.dart';
import 'package:ecommerence/screens/home.dart';
import 'package:ecommerence/screens/search.dart';
import 'package:ecommerence/screens/user_info.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/brandico_icons.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/fontelico_icons.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:fluttericon/maki_icons.dart';
import 'package:fluttericon/meteocons_icons.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttericon/web_symbols_icons.dart';
import 'package:fluttericon/zocial_icons.dart';

class BottomBarScreen extends StatefulWidget {

  static const routeName = '/BottomBarScreen';
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  List<Map<String, Object>> _pages = [];
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page' : HomeScreen(),
        // 'title' : 'Home Screen'
      },
      {
        'page' : FeedsScreen(),
        // 'title' : 'Feeds Screen'
      },
      {
        'page' : SearchScreen(),
        // 'title' : 'Search Screen'
      },
      {
        'page' : CartScreen(),
        // 'title' : 'Cart Screen'
      },
      {
        'page' : UserInfoScreen(),
        // 'title' : 'User Info Screen'
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      // centerTitle: true,
      //   title: Text(_pages[_selectedPageIndex]['title'].toString()),
      // ),
      body: _pages[_selectedPageIndex]['page']  as Widget,
      bottomNavigationBar: BottomAppBar(
        elevation: 5,
        shape: CircularNotchedRectangle(),
        notchMargin: 0.01,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: kBottomNavigationBarHeight * 0.98,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            child: BottomNavigationBar(
              onTap: _selectPage,
              backgroundColor: Theme.of(context).primaryColor,
              unselectedItemColor: Theme.of(context).textSelectionColor,
              selectedItemColor: Colors.purple,
              currentIndex: _selectedPageIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(MyAppIcons.home),
                  label: 'Home',
                  tooltip: 'Home',
                ),
                BottomNavigationBarItem(
                    icon: Icon(MyAppIcons.rss),
                    label: 'Feeds',
                    tooltip: 'Feeds',
                ),
                BottomNavigationBarItem(
                    icon: Icon(null),
                    // Icon(Icons.search,
                    // color: Colors.transparent,
                    // )
                    activeIcon: null,
                    label: 'Search',
                    tooltip: 'Search',
                ),
                BottomNavigationBarItem(
                    icon: Icon(MyAppIcons.bag),
                    label: 'Cart',
                    tooltip: 'Cart',
                ),
                BottomNavigationBarItem(
                    icon: Icon(MyAppIcons.user),
                    label: 'User',
                    tooltip: 'User',
                ),

              ],

            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked ,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
            backgroundColor: Colors.purple,
            hoverElevation: 10,
            splashColor: Colors.grey,
            tooltip: 'Search',
            elevation: 4,
            child: Icon(MyAppIcons.search),
            onPressed: () => setState(() {
              _selectedPageIndex = 2;
            }),
          ),
      ),

    );
  }
}
