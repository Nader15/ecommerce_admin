import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future clearAllData({String auth_token}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();

}