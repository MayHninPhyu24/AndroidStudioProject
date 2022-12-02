import 'package:ecommerence/screens/landing.dart';
import 'package:ecommerence/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserState extends StatelessWidget {
  const UserState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapShot){
          if(userSnapShot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if (userSnapShot.connectionState == ConnectionState.active){
            if(userSnapShot.hasData){
              return MainScreens();
            }else {
              return LandingScreen();
            }
          }else if (userSnapShot.hasData){
            return Center(
              child: Text('Error Occured'),
            );
          }else{
            return Text('No Output');
          }
    });
  }
}
