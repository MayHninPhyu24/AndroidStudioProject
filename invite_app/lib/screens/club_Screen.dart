
import 'package:agora_rtc_engine/rtc_engine.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invite_app/constants/agora.dart';
import 'package:invite_app/models/club_model.dart';
import 'package:invite_app/models/user_model.dart';

class ClubScreen extends StatefulWidget {
  final UserModel user;
  final ClubModel club;

  ClubScreen(this.user, this.club);


  @override
  _ClubScreenState createState() => _ClubScreenState();
}

class _ClubScreenState extends State<ClubScreen> {
  final _users = <int> [];
  final _infoStrings = <String> [];
  bool muted = false;
  RtcEngine? _engine;
  ClientRole role = ClientRole.Audience;
  List updatedSpeakers = [];

  void addSpeaker() {
    updatedSpeakers.add({
      'name' : widget.user.name,
      'phone' : widget.user.phone,
      // 'mic' : true,
    });
  }

  @override
  void initState() {
    updatedSpeakers = widget.club.speakers!;
    listerDatabase();
    widget.club.speakers!.forEach((speaker) {
      if(speaker['phone'] == widget.user.phone){
        setState(() {
          role = ClientRole.Broadcaster;
        });
      }
    });

    if(role == ClientRole.Audience) {
      initialize();
    }
    super.initState();
  }

  void listerDatabase() {
    FirebaseFirestore.instance.collection('clubs')
        .doc(widget.club.clubId)
        .snapshots()
        .listen((event) {
          var clubData = event.data();
          if(clubData!['status'] != widget.club.status) {
            setState(() {
              widget.club.status = clubData['status'];
            });
          }
          List allSpeakers = clubData['invited'];
          updatedSpeakers = allSpeakers;
    });
  }

  @override
  void dispose() {
    _users.clear();
    _engine?.leaveChannel();
    _engine?.destroy();
    super.dispose();
  }

  Future<void> initialize() async {
    if(AGORA_ID.isEmpty) {
      setState(() {
        _infoStrings.add('APP_ID missing, please provide it.');
      });
      _infoStrings.add('Agora Engine is not starting');
      return;
    }
    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    await _engine?.joinChannel(
        null,
        widget.club.clubId!,
        null, 0);
  }

  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(AGORA_ID);
    await _engine?.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine?.setClientRole(role);

  }
  void _addAgoraEventHandlers() {
    _engine?.setEventHandler(RtcEngineEventHandler(
      error: (code) {
        setState(() {
          final info = 'onError: $code';
          _infoStrings.add(info);
        });
      },
      joinChannelSuccess: (channel, uid, elapsed) async {
        setState(() {
          final info = 'onJoinChannel: $channel, uid: $uid';
          _infoStrings.add(info);
        });
      },
      leaveChannel: (stats) async {
        setState(() {
          _infoStrings.add('onLeaveChannel');
          _users.clear();
        });
      },
      userJoined: (uid, elapsed) {
        setState(() {
          final info = 'userJoined: $uid';
          _infoStrings.add(info);
          _users.add(uid);
        });
      },
      userOffline: (uid, reason) {
        setState(() {
          final info = 'userOffline: $uid , reason: $reason';
          _infoStrings.add(info);
          _users.remove(uid);
        });
      },
    ));
  }
  
  Widget? toolbar() {
    print(ClientRole.Audience);
    if(widget.club.status == "finished") {
      return Container(
        height: 50,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          children: [
            Text('Club is finished', style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),),
            SizedBox(height: 5,),
            Text('Thank you for listening', style: TextStyle(
              fontSize: 18
            ),)
          ],
        ),
      );
    }
    else if(widget.club.status == "new"){
      if(widget.club.createdBy == widget.user.phone){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                ),
                onPressed: (){
                Navigator.pop(context);
              }, 
                icon: Icon(Icons.exit_to_app),
                label: Text("Exit Club"),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                onPressed: () async{
                FirebaseFirestore.instance.collection('clubs')
                  .doc(widget.club.clubId)
                  .update({'status': "ongoing"});
                setState(() {
                  widget.club.status ="ongoing";
                });
                await initialize();
              },
                icon: Icon(CupertinoIcons.mic_circle_fill),
                label: Text("Start the Club"),
              ),
            ],
          ),
        );
      }
      else{
        DateTime dateTime = DateTime.parse(widget.club.dateTime!.toDate().toString());
        var formattedDateTime = DateFormat.MMMMEEEEd().add_jm().format(dateTime);
        return Container(
          height: 80,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              Text('Club is scheduled to start on', style: TextStyle(
                fontSize: 20, color: Colors.black,
              ),),
              SizedBox(height: 5,),
              Text('${formattedDateTime}', style: TextStyle(
                fontSize: 18,
                color: Colors.red,
              ),),
            ],
          ),
        );
      }
    }
    else if (role == ClientRole.Audience) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.amber,
              ),
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.exit_to_app),
                label: Text('Exit Club'),
            ),
            SizedBox(width: 15,),
            widget.club.type == 'public'
                ? ElevatedButton.icon(onPressed: (){
                addSpeaker();
                FirebaseFirestore.instance.collection('clubs')
                  .doc(widget.club.clubId)
                  .update({"invited" : updatedSpeakers})
                  .then((value) {
                    setState(() {
                      role = ClientRole.Broadcaster;
                    });
                });
                initialize();
            },
                icon: Icon(CupertinoIcons.hand_raised),
                label: Text('Join Discussion'),)

                : SizedBox.shrink(),
          ],
        ),
      );
    }
    else if (role == ClientRole.Broadcaster){
      return Container(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RawMaterialButton(onPressed: _onToggleMute,
              child: Icon(muted ? Icons.mic_off: Icons.mic,
                  color: muted? Colors.white: Colors.blueAccent,
                  size: 20,),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor: muted? Colors.blueAccent: Colors.white,
              padding: EdgeInsets.all(12),
            ),

            widget.club.createdBy == widget.user.phone
                ? ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                onPressed: (){
                  FirebaseFirestore.instance.collection('clubs')
                      .doc(widget.club.clubId)
                      .update({"status" : "finished"});
                  Navigator.pop(context);
                },
                  icon: Icon(Icons.exit_to_app),
                  label: Text('End Club'),
                )
                : ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                ),
               onPressed: (){
                  Navigator.pop(context);
                },
                  icon: Icon(Icons.exit_to_app),
                  label: Text('Exit Club'),
                )
          ],
        ),
      );
    }
    
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine?.muteLocalAudioStream(muted);
    updatedSpeakers.forEach((speaker) {
      if(speaker['phone'] == widget.user.phone) {
        speaker['mic'] = muted;
      }
    });

    FirebaseFirestore.instance.collection('clubs')
      .doc(widget.club.clubId)
      .update({'invited' : updatedSpeakers});
  }

  @override
  Widget build(BuildContext context) {
    print('Agora Events');
    print(_infoStrings.toString());

    return Scaffold(
      backgroundColor: Color(0xff1ef35),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
            children: [
              Image.asset('images/image4.png', height: 150,),
              SizedBox(height: 20,),
              Text(widget.club.title.toString(), style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
              Text(widget.club.category.toString(), style: TextStyle(
                fontSize: 20,
              ),),
              SizedBox(height: 50,),
              Row(
                children: [
                  Expanded(child: Divider()),
                  Text('Speakers', style: TextStyle(
                    color: Colors.grey
                  ),),
                  Expanded(child: Divider()),
                ],
              ),
              StreamBuilder(
                builder: (context,AsyncSnapshot snapshot){
                  if(snapshot.hasData) {
                    var speakers = snapshot.data.data();
                    return Expanded(child: ListView.builder(
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.teal,
                              child: Icon(Icons.person,color: Colors.white,),
                            ),
                            trailing: speakers['invited'][index]['mic'] == true ?
                            Icon(Icons.mic_off) : Icon(Icons.mic, color: Colors.green,),
                            title: Text(speakers['invited'][index]['name']),
                          );
                        },
                        itemCount: speakers['invited'].length,
                    ));
                  }
                  return CircularProgressIndicator();
              },
                stream: FirebaseFirestore.instance.collection('clubs')
                  .doc(widget.club.clubId).snapshots(),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: toolbar(),
    );
  }
}
