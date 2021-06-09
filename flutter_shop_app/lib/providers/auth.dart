import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_shop_app/models/http_exception.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart' as preferences;
class Auth with ChangeNotifier{
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer authTimer;
  bool get isAuth {
    return token !=null;
  }
  String get userId{ return _userId;}
  String get token {
    if(
        _expiryDate!=null&&
        _expiryDate.isAfter(DateTime.now())&&
        _token!=null
      )return _token;
    return null;
  }

  void logOut(){
    this._expiryDate =null;
    this._userId = null;
    this._token = null;
    authTimer?.cancel();
    preferences.SharedPreferences.getInstance().then((value) => value.clear());
    authTimer = null;
    notifyListeners();
  }

  void autoLogout(){
    final time = _expiryDate.difference(DateTime.now()).inSeconds;
    authTimer?.cancel();
    this.authTimer = Timer(Duration(seconds: 100),this.logOut);
  }


  Future<void> singup(String email,String password) async{
    String url = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAEH9n1aDO-FKMJx_dAAwBe4n6OQBydO5w";
  try{
    final response = await http.post(url,body: json.encode({
      'email':email,
      'password':password,
      "returnSecureToken":true
    }));
    final body = json.decode(response.body);
    if(body["error"]!=null)
      throw HttpException(body["error"]["message"]);
  }catch(error){
    throw error;
  }
  }
  Future<void> login(String email,String password)async {
    try{
      String url = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAEH9n1aDO-FKMJx_dAAwBe4n6OQBydO5w";
      final response =  await http.post(url,body: json.encode({
        'email':email,
        'password':password,
        "returnSecureToken":true
      }));
      final body = json.decode(response.body);
      if(body["error"]!=null)
        throw HttpException(body["error"]["message"]);
      _token = body["idToken"];
      _userId = body["localId"];
      _expiryDate = DateTime.now().add(Duration(seconds: int.parse(body["expiresIn"])));
      notifyListeners();
      autoLogout();
      final pref = await preferences.SharedPreferences.getInstance();
      String data = json.encode({
        "token":_token,
        "userId":_userId,
        'expiryDate':_expiryDate.toIso8601String()
      });
      pref.setString("userdata",data);
    }catch(error){
      throw error;
    }
  }

  Future<bool> tryAuthLogin()async {
    final prefs = await preferences.SharedPreferences.getInstance();
    print("authlogin with ${prefs.get("userdata")}");
    if(prefs.containsKey("userdata")==false)
      return false;
    final data = json.decode(prefs.get("userdata"));
    final expiredate = DateTime.parse(data["expiryDate"]);
    if(expiredate.isBefore(DateTime.now()))
      return false;
    _expiryDate = expiredate;
    print("EXP DATE");
    _token = data["token"];
    _userId  = data["userId"];
    notifyListeners();
    autoLogout();
    return true;
  }
}
