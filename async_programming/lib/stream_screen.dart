import 'package:flutter/material.dart';
import 'dart:async';
class StreamScreen extends StatelessWidget {
  final StreamController streamController = StreamController();

  void streamData() async {
    streamController.stream.listen((data) {
      print(data);
    });
    for(int i=0; i<4; i++){
      streamController.add("You got a message!");
      await Future.delayed(Duration(seconds: 2),(){
        print("Read");
      });
    }
  }

  Stream myStream() async*{
    for(var i=0; i<10; i++){
      yield i;
      await Future.delayed(Duration(seconds: 2));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stream Tutorial"),
      ),
      body: StreamBuilder(
        stream: myStream(),
        builder: (context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return Center(
              child: Text(snapshot.data.toString()),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Text("Add"),
        onPressed: (){
          streamController.add("You have a new notification");
        },
      ),
    );
  }
}
