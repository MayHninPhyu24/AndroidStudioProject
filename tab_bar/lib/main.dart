import 'package:flutter/material.dart';
import './home.dart';
import './contact.dart';
import './mail.dart';
import './sms.dart';
import './profile.dart';
import './setting.dart';
import './about_us.dart';
import './contact_us.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
      routes: {
        'home': (BuildContext ctx) => Home(),
        'about_us': (BuildContext ctx) => About(),
        'contact': (BuildContext ctx) => Contact(),
        'contact_us': (BuildContext ctx) => ContactUs(),
        'mail' : (BuildContext ctx) => Mail(),
        'profile': (BuildContext ctx) => Profile(),
        'setting': (BuildContext ctx) => Setting(),
        'sms': (BuildContext ctx) => SMS(),
        'main': (BuildContext ctx) => MyApp(),
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<MyApp> {
  String? title;
  String? currentPath;


  void selectScreen(BuildContext context,int n) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_){
          if (n==1) {
            title = "Profile";
            return Profile();
          }
          else if (n==2) return Setting();
          else if (n == 3) return ContactUs();
          return About();
        }
        ));
  }


  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Communicator'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home),text: ("Home"),),
                Tab(icon: Icon(Icons.perm_contact_cal_sharp), text: "Contact Book",),
                Tab(icon: Icon(Icons.contact_mail), text: "Mail",),
                Tab(icon: Icon(Icons.sms_sharp), text: "SMS",)
              ],
            ),
          ),
          body: TabBarView(
            children: [
                Home(),
                Contact(),
                Mail(),
                SMS(),
            ],
          ),
          drawerScrimColor: Colors.pinkAccent.withOpacity(0.5),
          drawer: Drawer(
            child: ListView(
              children: [
                ListTile(
                  title: Text("Profile", style: TextStyle(fontSize: 20),),
                  subtitle: Text("Profile"),
                  leading: Icon(Icons.supervised_user_circle_sharp),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => selectScreen(context,1),
                ),
                ListTile(
                  title: Text("Setting", style: TextStyle(fontSize: 20),),
                  subtitle: Text("Setting"),
                  leading: Icon(Icons.settings),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => selectScreen(context,2),
                ),
                ListTile(
                  title: Text("About Us", style: TextStyle(fontSize: 20),),
                  subtitle: Text("About Us"),
                  leading: Icon(Icons.account_box_outlined),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => selectScreen(context,3),
                ),
                ListTile(
                  title: Text("Contact Us", style: TextStyle(fontSize: 20),),
                  subtitle: Text("Contact Us"),
                  leading: Icon(Icons.contact_phone_rounded),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () => selectScreen(context,4),
                ),

              ],
            ),
          ),
        ));


  }
}