import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answerText;
  final VoidCallback x;
  Answer(this.x,this.answerText);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.blueAccent,
        textColor: Colors.white,
        child: Text(answerText, style: TextStyle(fontSize: 25),),
        onPressed: x,
      ),
    );
  }
}
