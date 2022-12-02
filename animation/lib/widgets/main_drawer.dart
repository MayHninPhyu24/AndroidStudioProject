import 'package:animation/screens/animation_screen.dart';
import 'package:animation/screens/async_programming_screen.dart';
import 'package:animation/screens/dart_intro_screen.dart';
import 'package:animation/screens/flutter_basic_screen.dart';
import 'package:animation/screens/more_ui.dart';
import 'package:animation/screens/state_management_screen.dart';
import 'package:animation/screens/tabs_screen.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);
  Widget buildListTile(String title, IconData icon,
      Function() tapHandler, BuildContext ctx) {
    return ListTile(
      leading: Icon(icon, size:26, color: Theme.of(ctx).splashColor,),
      trailing: Icon(Icons.arrow_forward_ios, size: 26,
        color: Theme.of(ctx).splashColor,
      ),
      title: Text(title, style: TextStyle(
        color: Theme.of(ctx).textTheme.bodyText1!.color,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Text("Flutter Guide",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Colors.white
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.pinkAccent
            ),
          ),
          SizedBox(height: 20,),
          buildListTile("Dart Introduction",Icons.integration_instructions_rounded,
                  (){Navigator.of(context).pushReplacementNamed(DartIntroScreen.routeName);},
              context),
          Divider(
            height: 10,
            color: Colors.black54,
          ),
          buildListTile("Flutter Basics",Icons.flutter_dash_sharp,
                  (){Navigator.of(context).pushReplacementNamed(FlutterBasicScreen.routeName);},
              context),
          Divider(
            height: 10,
            color: Colors.black54,
          ),
          buildListTile("Async Programming",Icons.code,
                  (){Navigator.of(context).pushReplacementNamed(AsyncProgrammingScreen.routeName);},
              context),
          Divider(
            height: 10,
            color: Colors.black54,
          ),
          buildListTile("Animation",Icons.animation,
                  (){Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);},
              context),
          Divider(
            height: 10,
            color: Colors.black54,
          ),
          buildListTile("State Management",Icons.source,
                  (){Navigator.of(context).pushReplacementNamed(StateManagementScreen.routeName);},
              context),
          Divider(
            height: 10,
            color: Colors.black54,
          ),
          buildListTile("More Flutter UI",Icons.design_services_outlined,
                  (){Navigator.of(context).pushReplacementNamed(FlutterUIScreen.routeName);},
              context),
          Divider(
            height: 10,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }
}
