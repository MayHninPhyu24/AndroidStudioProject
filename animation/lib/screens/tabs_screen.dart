import 'package:animation/screens/animation_screen.dart';
import 'package:animation/providers/all_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/main_drawer.dart';
import 'more_ui.dart';


class TabsScreen extends StatefulWidget {
  static const routeName = 'tabs_screen';

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages = [];
  int _selectedPageIndex = 0;

  @override
  void initState() {
    Provider.of<AllProvider>(context, listen:false).getData();
    super.initState();
  }

  void _selectPage(int value) {
    setState(() {
      _selectedPageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    _pages = [
      {
        'page' : AnimationScreen(),
        'title' : 'Animation'
      },
      {
        'page' : FlutterUIScreen(),
        'title' : 'More Flutter UI'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'].toString()),
      ),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      drawer: MainDrawer(),
    );
  }
}
