import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  Future<void> isLoggedIn(){

  }
  getSession()
  Future<void> saveSession(String forename, String surname, String email) async{
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('forename', forename);
    await prefs.setString('surname', surname);
  await prefs.setString('email', email);
  }
  clearSession()

}