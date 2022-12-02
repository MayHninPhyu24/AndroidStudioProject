import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invite_app/models/club_model.dart';
import 'package:invite_app/models/user_model.dart';
import 'package:permission_handler/permission_handler.dart';

import '../screens/club_Screen.dart';

class OngoingClub extends StatelessWidget {
  final UserModel user;

  OngoingClub(this.user);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFEE7E4D3)
      ),
      child: StreamBuilder(
        stream : FirebaseFirestore.instance.collection('clubs')
                .where('status', isEqualTo: 'ongoing').snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            if(snapshot.data!.docs.length < 1) {
              return Container(
                width: double.infinity,
                child: Text(
                  'No Ongoing club at this moment', style: TextStyle(
                  color: Colors.teal
                ),
                  textAlign: TextAlign.center,
                ),
              );
            }
            return Column(
              children: snapshot.data.docs.map<Widget>((club) {
                DateTime dataTime = DateTime.parse(club['dateTime'].toDate().toString());
                var formattedTime = DateFormat.jm().format(dataTime);
                ClubModel clubDetail = new ClubModel.fromMap(club);
                return GestureDetector(
                  onTap: () async{
                    PermissionStatus micStatus = await Permission.microphone.status;
                    if(!micStatus.isGranted){
                      await Permission.microphone.request();
                    }
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>ClubScreen(user, clubDetail)));
                  },
                  child: Padding(padding: EdgeInsets.only(bottom: 10,),
                    child:  Row(
                      children: [
                        Text("${formattedTime.toString()}", style: TextStyle(
                            color: Colors.green
                        ),),
                        Flexible(child: Text('${clubDetail.title.toString()}', style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                          overflow: TextOverflow.ellipsis,
                        ))
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }else{
            return Container(
              width: double.infinity,
              child: Text(
                'No Ongoing club at this moment', style: TextStyle(
                  color: Colors.teal
              ),
                textAlign: TextAlign.center,
              ),
            );
          }
        },
      ),
    );
  }
}
