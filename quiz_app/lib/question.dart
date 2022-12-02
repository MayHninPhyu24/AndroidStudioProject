import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text(questionText,
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center
          ),
        ],
      ),
    );
  }
}
