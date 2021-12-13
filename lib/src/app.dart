import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_group_links/main.dart';
import 'package:whatsapp_group_links/src/screens/authentication.dart';
import 'package:whatsapp_group_links/src/screens/home.dart';

class Wrapper extends StatefulWidget {
  Wrapper({Key key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
   return (prefs.getString('token') != null) ? Home() : Authentication();
  }
}
