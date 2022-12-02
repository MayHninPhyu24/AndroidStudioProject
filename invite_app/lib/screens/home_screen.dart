import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:invite_app/main.dart';
import 'package:invite_app/models/user_model.dart';
import 'package:invite_app/screens/create_club.dart';
import 'package:invite_app/screens/invite_screen.dart';
import 'package:invite_app/screens/my_club.dart';
import 'package:invite_app/screens/profile_screen.dart';
import 'package:invite_app/widgets/ongoing_club.dart';
import 'package:invite_app/widgets/upcoming_club.dart';

class HomeScreen extends StatefulWidget {

  final UserModel user;

  const HomeScreen({required this.user});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    if(widget.user.name == ''){
      Future.microtask(() => Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context)=> ProfileScreen(widget.user))));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1efe5),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: Text('Home', style: TextStyle(color: Colors.black),),
        actions: [
          IconButton(
              onPressed: () async{
                FirebaseAuth.instance.signOut().then((value){
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => AuthenticateUser(),
                  ));
                });
              },
              icon: const Icon(Icons.power_settings_new_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            OngoingClub(widget.user),
            SizedBox(height: 10,),
            Text('Upcoming Week', style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 10,),
            Icon(Icons.arrow_circle_down),
            UpcomingClub(widget.user),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder:(context)=> CreateAClub(widget.user)));
        },
        child: Icon(
          Icons.add,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.mic),
              title: Text('My New Clubs'),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=> MyClubScreen(widget.user)));
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Invite'),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=> InviteScreen(user:widget.user)));
              },
            ),
          ],
        ),
      ),
    );
  }
}
