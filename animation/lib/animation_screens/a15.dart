import 'dart:math';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';

class AnimationScreenA15 extends StatefulWidget {
  static const routeName = "/AnimationScreenA15";

  const AnimationScreenA15({Key? key}) : super(key: key);

  @override
  _AnimationScreenA15State createState() => _AnimationScreenA15State();
}

class _AnimationScreenA15State extends State<AnimationScreenA15> {
  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute.of(context)!.settings.arguments as Map<String , String>;

    return Scaffold(
      appBar: AppBar(title: Text('${routeArg["title"]}'),),
      body: WidgetWithCodeView(
        child: SomeWidget(),
        sourceFilePath: 'lib/animation_screens/a15.dart',
        iconBackgroundColor: Colors.white,
        iconForegroundColor: Colors.pink,
        labelBackgroundColor: Theme.of(context).canvasColor,
      ),
    );
  }
}

class SomeWidget extends StatefulWidget {

  @override
  State<SomeWidget> createState() => _SomeWidgetState();
}

enum AuthMode{SignUp, Login}


class _SomeWidgetState extends State<SomeWidget> with SingleTickerProviderStateMixin{

  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  final _passwordController = TextEditingController();
  late AnimationController _controller;
  late Animation<double> _animation;
  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.SignUp;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),);
    _animation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn));

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>  Scaffold(
    body: Center(
      child: Card(
        margin: EdgeInsets.all(20),
        elevation: 8,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: _authMode==AuthMode.SignUp? 320:260,
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: "E-Mail"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      if (val!.isEmpty || !val.contains('@')) {
                        return "Invalid email!";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      _authData['password'] = val!;
                      print(_authData['password']);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Password"),
                    controller: _passwordController,
                    obscureText: true,
                    validator: (val) {
                      if (val!.isEmpty || val.length <= 5) {
                        return "Password is too short!";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      _authData['email'] = val!;
                      print(_authData['email']);
                    },
                  ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      constraints: BoxConstraints(
                        minHeight: _authMode == AuthMode.SignUp? 60: 0,
                        maxHeight: _authMode == AuthMode.SignUp? 120: 0,
                      ),
                      child: FadeTransition(
                        opacity: _animation,
                        child: TextFormField(
                          enabled: _authMode == AuthMode.SignUp,
                          decoration:
                          InputDecoration(labelText: 'Confirm Password'),
                          obscureText: true,
                          validator: _authMode == AuthMode.SignUp
                              ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                            return null;
                          }
                              : null,
                        ),
                      ),
                    ),
                  SizedBox(
                      height: 20
                  ),
                  RaisedButton(
                    child:
                    Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                    onPressed: _submit,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                    EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryTextTheme.button?.color,
                  ),
                  FlatButton(
                    child: Text(
                        '${_authMode == AuthMode.Login ? 'SIGN UP' : 'LOGIN'} INSTEAD'),
                    onPressed: _switchAuthMode,
                    padding:
                    EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
  void _submit() {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    if (_authMode == AuthMode.Login) {
      // Log user in
    } else {
      // Sign user up
    }
  }
}
