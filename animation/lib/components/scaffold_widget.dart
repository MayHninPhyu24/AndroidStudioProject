import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';

Widget scaffoldWidget(context,widget, title, filePath)=> Scaffold(
  appBar: AppBar(title: Text('$title')),
  body: WidgetWithCodeView(
    child: widget,
    sourceFilePath: filePath,
    iconBackgroundColor: Colors.white,
    iconForegroundColor: Colors.pink,
    labelBackgroundColor: Theme.of(context).canvasColor,
  ));

