import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:invite_app/models/user_model.dart';
import 'package:invite_app/screens/auth_screen.dart';
import 'package:invite_app/screens/home_screen.dart';

import 'screens/not_invited_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Club House',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: AuthenticateUser(),
    );
  }
}

class AuthenticateUser extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future checkCurrentUser() async {
    if(_firebaseAuth.currentUser != null) {
      var userInvited = await _fireStore.collection('invites').where(
          'invitee' ,isEqualTo: _firebaseAuth.currentUser!.phoneNumber).get();
      if(userInvited.docs.length <1) {
        return NotInvitedScreen();
      }

      var userExist = await _fireStore
          .collection('users')
          .where('uid', isEqualTo: _firebaseAuth.currentUser?.uid)
          .get();
      UserModel user = UserModel.fromMap(userExist.docs.first);

      return HomeScreen(user: user);
    }else{
      return AuthScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.blue,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }else{
              return snapshot.data as Widget;
          }
        },
        future: checkCurrentUser(),
    );
  }
}
