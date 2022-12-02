import 'package:flutter/material.dart';
import 'package:quiz_app/answer.dart';
import './question.dart';
import './answer.dart';
import 'package:quiz_app/quiz.dart';

main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _questionIndex = 0;
  void answerQuestion() {
    if(_questionIndex == 2) {
      _questionIndex = -1;
    }
    setState(() {
      _questionIndex += 1;
    });
    print(_questionIndex);
    print("Answer choose ${{_questionIndex}}");
  }

  final List _question = [
    {
      'questionText': "What\'s is your favourite color?",
      'answers':['Pink','Red','Yellow','Blue']
    },
    {
      'questionText': "What\'s is your favourite animal?",
      'answers':['Cat','Dog','Elephant','Rabbit']
    },
    {
      'questionText': "What\'s is your favourite City?",
      'answers':['Myanmar','Thai','Japan','Korea']
    },
    {
      'questionText': "What\'s is your favourite Actor?",
      'answers':['Hein Wai Yan','Nay Toe','Pay Ti Oo','Pai Tha Kon']
    },
  ];




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Quiz App"),
        ),
        body: Container(
         width: double.infinity,
         child: Column(
           children: [
             Question(_question[_questionIndex]['questionText']),
             ...(_question[_questionIndex]['answers'] as List).map((answer){
                  return Answer(answerQuestion, answer);
             }).toList(),

           ],
         ),

        ),
      ),
    );
  }
}
