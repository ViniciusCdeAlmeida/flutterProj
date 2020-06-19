import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expireDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expireDate != null &&
        _expireDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userID {
    return _userId;
  }

  Future<void> _authenticate(
      String email, String password, String urlSeg) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSeg?key=AIzaSyDMYoeV_th7SIPtYrDfHmxECB7o1fm36s8';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expireDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expireDate': _expireDate.toIso8601String()
      });
      prefs.setString('usrData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<bool> tryAutoLog() async{
    final prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey('userData')){
      return false;
    }
    final extData = json.decode(prefs.getString('userData')) as Map<String, Object>;
    final extDate = DateTime.parse(extData['expireDate']);

    if(extDate.isAfter(DateTime.now())){
      return false;
    }

    _token = extData['token'];
    _userId = extData['userId'];
    _expireDate = extDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _expireDate = null;
    _userId = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null; 
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear(); 
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeExp = _expireDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(
      Duration(seconds: timeExp),
      logout,
    );
  }
}
