import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Must be in dart 2
//--preview dart 2

//Actions
enum Actions {Increment, Decrement}

//reducer
int reducer(int state, dynamic action) {
  if(action == Actions.Increment) state++;
  if(action == Actions.Decrement) state--;
  return state;
  return state;
}

void main() {
  final store = Store<int>(reducer, initialState:0);
  runApp(new MaterialApp(
    home:new MyApp(),
  ));
}

class MyApp extends StatelessWidget {

}