import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;

  bool get isAuth {
    return _token != null;
  }
  String? get token{
    if(_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null){
      return _token!;
    }
    return null;
  }
  Future<void> _authenticate(String email, String password, String urlSegment) async{
    final url = 'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDd2ptiraZztk_0gc9B3QYH8vIrN2LvR8E';

    try{
      final res = await http.post(Uri.parse(url), body: json.encode({
        'email' : email,
        'password' : password,
        'returnSecureToken' : true
      }));
      final resData = json.decode(res.body);
      if(resData['error'] != null){
        throw "${resData['error']['message']}";
      }
      _token = resData['idToken'];  // response payload from documentation
      _userId = resData['localId'];
      _expiryDate = DateTime.now().add(Duration(seconds: int.parse(resData['expiresIn'])));
      //autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'user_id' : _userId,
        'expiryDate': _expiryDate!.toIso8601String(),
      });
      prefs.setString('userData', userData);
    }catch(error){
      throw error;
    }
  }

  Future<bool> tryAutoLogin () async{
    final prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey('userData')){
      return false;
    }

    final extractedUserData = json.encode(prefs.getString('userData')!) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate'] as String);
    if(expiryDate.isBefore(DateTime.now())){
      return false;
    }
    _token = extractedUserData['token'] as String;
    _userId = extractedUserData['userId'] as String;
    _expiryDate = expiryDate;
    notifyListeners();
    //autoLogout();
    return true;
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  void logout() async{
    _token = null;
    _userId = null;
    _expiryDate = null;

    if(_authTimer != null) {
      _authTimer?.cancel();
      _authTimer = null;
      print(_authTimer);
    }
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void autoLogout() {
    if(_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
  }