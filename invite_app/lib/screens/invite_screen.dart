import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:invite_app/models/user_model.dart';

class InviteScreen extends StatefulWidget {
  final UserModel user;

  const InviteScreen({required this.user});

  @override
  _InviteScreenState createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  final TextEditingController inviteController = TextEditingController();
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  bool isLoading = false;
  var selectedName = "";

  @override
  void initState() {
    super.initState();
    selectContact();
  }

  @override
  void dispose() {
    inviteController.clear();
    inviteController.dispose();
    super.dispose();
  }

  Future selectContact() async {
    if (await FlutterContacts.requestPermission()) {
      var contact = await FlutterContacts.openExternalPick();
      if(contact != null) {
        setState(() {
          inviteController.text = contact.phones.single.normalizedNumber;
          selectedName = contact.name.first;
        });
      }else{
        print('No contact selected');
      }
    }else{
      print("permission Denied");
    }
  }

  Future inviteFriend() async {
    if(inviteController.text.trim().length > 8) {
      setState(() {
        isLoading = true;
      });
      _fireStore.collection('invites').add({
        'invitee' : inviteController.text,
        'invitedBy': widget.user.phone,
        'date' : DateTime.now(),
      }).then((value) {
        int invitesLeft = widget.user.invitesLeft! - 1;
        _fireStore.collection('users').doc(widget.user.uid).update({
          'invitesLeft' : invitesLeft,
        }).then((value) {
          setState(() {
            widget.user.invitesLeft = invitesLeft;
            isLoading = false;
            inviteController.text = "";
            selectedName = "";
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invite your friend'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: Text('${widget.user.invitesLeft}', style: TextStyle(
                fontSize: 30
              ),),
            ),
            Center(
              child: Text('Invites Left', style: TextStyle(
                fontSize: 30,
              ),),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 30, vertical: 10),
              child: TextField(
                controller: inviteController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Friend's phone number with country code",
                  hintText: "(eg:+95123....)"
                ),
              ),
            ),
            SizedBox(height: 30,),
            isLoading? CircularProgressIndicator() : Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                child: Text('Invite ${selectedName} Now', style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),),
                onPressed: (){
                  inviteFriend();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
