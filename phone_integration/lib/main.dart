import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';


Permission permissionFromString(String value) {
  late Permission permissions;
  print(value);
  print(Permission.values);
  for(Permission item in Permission.values) {
    if(item.toString() == value) {
      permissions = item;
      break;
    }
  }
  return permissions;
}

void main() {
  await SuperEasyPermissions.askPermission(permissionFromString('Permissions.ReadContacts'));
  await SuperEasyPermissions.askPermission(permissionFromString('Permissions.WriteContacts'));

  runApp(new MaterialApp(
    home:new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<MyApp> {

  void _showURL() {
    _launch('http://www.myanbox.com');
  }

  void _showEmail() {
    _launch('mailto:mayhninphyu@findix.co.jp');
  }

  void _showSMS() {
    _launch('sms:0912345678');
  }

  void _showTelephone() {
    _launch('tel:0912345678');
  }

  void _launch(String urlString) async {
    if(await canLaunch(urlString)){
      await launch(urlString);
    }else{
      throw 'Could not launch';
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Name Here'),
      ),
    body: Container (
        padding: EdgeInsets.all(32.0),
        child:Center(
            child: Column(
                children: <Widget>[
                  RaisedButton(onPressed: _showURL, child:Text('Show URL'),),
                  RaisedButton(onPressed: _showEmail, child:Text('Show Email'),),
                  RaisedButton(onPressed: _showSMS, child:Text('Show SMS'),),
                  RaisedButton(onPressed: _showTelephone, child:Text('Show Telephone'),),
                ],
            ),
        ),
    ),
    );
  }
}