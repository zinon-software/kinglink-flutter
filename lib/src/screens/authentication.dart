
import 'package:flutter/material.dart';
import 'package:whatsapp_group_links/src/screens/auth/login_screen.dart';
import 'package:whatsapp_group_links/src/screens/auth/signup_screen.dart';


class Authentication extends StatefulWidget {
  const Authentication({ Key key }) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

  bool _isToggle = true;
  void toggleScreen(){
    setState(() {
      _isToggle = !_isToggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isToggle){
      return SignupScreen(toggleScreen: toggleScreen);
    } else{
      return LoginScreen(toggleScreen: toggleScreen);
    }
  }
}