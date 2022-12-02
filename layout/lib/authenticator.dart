import 'package:flutter/material.dart';

class Authenticator extends StatefulWidget {
  Authenticator({Key? key, required this.onAuthenticated});
  final ValueChanged<bool> onAuthenticated;

  @override
  _AuthenticatorState createState() =>  _AuthenticatorState(onAuthenticated: onAuthenticated);
}

class _AuthenticatorState extends State<Authenticator> {

  _AuthenticatorState({Key? key, required this.onAuthenticated});

  final TextEditingController _name = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _controller = TextEditingController();

  ValueChanged<bool> onAuthenticated;

  void _onPressed() {

    if (_name.text =='' || _pass.text=='') {
      onAuthenticated(false);
    } else {
      if (_name.text != 'user' || _pass.text != '1234') {
        onAuthenticated(false);
      } else {
        onAuthenticated(true);
      }
    }
  }


  Widget build(BuildContext context) {
    return  Card(
      child:  Padding(
        padding:  EdgeInsets.all(15.0),
        child:  Column(
          children: <Widget>[
             TextField(
              controller: _name,
              decoration:  InputDecoration(labelText: 'Username'),
            ),
             TextField(
              controller: _pass,
              decoration:  InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
             Padding(
              padding:  EdgeInsets.all(10.0),
              child:  RaisedButton(onPressed: _onPressed, child:  Text('Login'),),)
          ],
        ),
      ),
    );

  }
}