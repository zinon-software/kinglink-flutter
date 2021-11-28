import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_group_links/src/auth/authentication.dart';
import 'package:whatsapp_group_links/static/constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


import 'home/home_screen.dart';


class Application extends StatelessWidget {
  const Application({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Whatsapp Group Links',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.almaraiTextTheme(Theme.of(context).textTheme),
        primaryColor: kPrimaryColor, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kPrimaryColor),
      ),
      // Arabic RTL
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale("ar", "AE")],
      locale: Locale("ar", "AE"),

      home: Wrapper(),
    );
  }
}


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
      return HomeScreen();
    } else{
      return Authentication();
    }
  }
}