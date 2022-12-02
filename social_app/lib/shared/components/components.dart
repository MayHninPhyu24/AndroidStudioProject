import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/shared/network/styles/icon_broken.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required VoidCallback function,
  required String text,
})=> Container(
    width: width,
    child: MaterialButton(
      onPressed: function,
      child: Text(isUpperCase ? text.toUpperCase(): text,
        style: TextStyle(
            color: Colors.white
        ),
      ),
    ),
    decoration : BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: background,
    )

);

Widget defaultTextButton({
  required VoidCallback function,
  required String text,
}) => TextButton(onPressed: function,
    child: Text(text));

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget)
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget,),
        (route) => false
);


void showToast({
  required String text,
  required ToastStates state,
}) =>Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

//enum
enum ToastStates{
  SUCCESS,
  ERROR,
  WARNING
}

Color chooseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  required String title,
  List<Widget>? actions
}) => AppBar(
  leading: IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon: Icon(
      MyFlutterApp.keyboard_arrow_left,
      size: 30.0,
    ),
  ),
  title: Text(title.toString()),
  titleSpacing: 5.0,
  actions: actions,
);