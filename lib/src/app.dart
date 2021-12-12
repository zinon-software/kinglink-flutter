import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_group_links/src/screens/authentication.dart';
import 'package:whatsapp_group_links/src/screens/home.dart';



class Wrapper extends StatefulWidget {
  Wrapper({Key key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  SharedPreferences sharedPreferences;

  String token;

  @override
  void initState() {
    super.initState();
    checkLoginStatus(); // run method login in status token equal null
  }

  // we usding this method to check if the user login or null
  void checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") != null) {
      setState(() {
        token = sharedPreferences.getString("token");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (token != null) {
      return Home();
    } else {
      return Authentication();
    }
  }
}
