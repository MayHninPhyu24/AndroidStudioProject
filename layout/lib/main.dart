import 'package:flutter/material.dart';
import 'authenticator.dart';

void main() {
  runApp(new MaterialApp(
    home:new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}


class _State extends State<MyApp> {

  // TextEditingController _user = TextEditingController();
  // TextEditingController _pass = TextEditingController();
  late bool _isAuthenticated;

  void _onAuthenticated(bool value) {
    setState(()=> _isAuthenticated = value);
  }

  @override
  void initState() {
    _isAuthenticated = false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Form'),
        backgroundColor: Colors.redAccent,
      ),
    body: Container (
        padding: EdgeInsets.all(32.0),
        child:Center(
            child: Column(
                children: <Widget>[
                  // Card(
                  //   child:Container(
                  //     padding: EdgeInsets.all(32.0),
                  //     child:Column(
                  //       children:<Widget>[
                  //         Text('Please Login'),
                  //         Row(
                  //           children:<Widget>[
                  //             Text('Username: '),
                  //             Expanded(child:TextField(controller:_user,))
                  //           ],
                  //         ),
                  //         Row(
                  //           children:<Widget>[
                  //             Text('Password: '),
                  //             Expanded(child:TextField(controller:_pass,obscureText: true,))
                  //           ],
                  //         ),
                  //         Padding(
                  //             padding:EdgeInsets.all(32.0),
                  //             child: RaisedButton(onPressed:()=>print('Login ${_user.text}'), child:Text('Login'),)
                  //         )
                  //       ]
                  //     )
                  //   )
                  // ),
                  Authenticator(onAuthenticated: _onAuthenticated,),
                  Text('Authenticated: ${_isAuthenticated}')                  // Expanded(child: Image.asset('images/logo.png'),),
                  // Expanded(child: Image.network('http://voidrealms.com/images/smile.jpg'),),


                ],
            ),
        ),
    ),
    );
  }
}