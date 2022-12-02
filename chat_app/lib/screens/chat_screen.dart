import 'package:chat_app/chat/messages.dart';
import 'package:chat_app/chat/new_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title : Text('Flutter Chat'),
          actions: [
            DropdownButton(
                underline: Container(),
                icon: Icon(
                Icons.more_vert,
                color : Theme.of(context).primaryIconTheme.color,
            ),
                items: [
                  DropdownMenuItem(child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8,),
                      Text('Logout', style: TextStyle(
                        color: Colors.white70
                      )),
                    ],
                  ),
                    value: 'logout',
                  ),
                ], onChanged: (itemIdentifier){
                  if(itemIdentifier == 'logout'){
                    FirebaseAuth.instance.signOut();
                  }
                })
          ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),

    );
  }
}
