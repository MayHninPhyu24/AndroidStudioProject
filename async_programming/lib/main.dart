import 'package:async_programming/future_screen.dart';
import 'package:async_programming/stream_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      title: "My First App",
      home: StreamScreen(),
    ),
  );
}