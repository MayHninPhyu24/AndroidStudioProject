import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';


class NotInvitedScreen extends StatelessWidget {
  const NotInvitedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('No Authenticate'),
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
      body: Container(
        color: Colors.redAccent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_add_disabled, size: 40, color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}
