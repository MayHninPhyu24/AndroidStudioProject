import 'package:flutter/material.dart';
import './contact.dart';
import './mail.dart';
import './sms.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() =>   _HomeState();
}

class _HomeState extends State<Home> {
  void selectScreen(BuildContext context,int n) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_){
          if (n==2) return Contact();
          else if (n == 3) return Mail();
          else if(n == 4)  return SMS();
          return Home();
        }
    ));
  }

  Widget build(BuildContext context) {

    return   Scaffold(
      appBar:   AppBar(
        title:   Text('Home'),
      ),
      body:   Container(
          padding:   EdgeInsets.all(32.0),
          child:   Center(
            child:   Column(
              children: <Widget>[
                  Text('Welcome Home'),
              ],
            ),
          )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          print("Home");
        },
      ),
    );
  }
}