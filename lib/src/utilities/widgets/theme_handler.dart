import 'package:flutter/material.dart';

import '../constants/color.dart';

ThemeData themeData() {
  return ThemeData(
    primarySwatch: Colors.blue,
    // fontFamily: 'HelveticaNeue',
    backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
    accentColor: Color.fromRGBO(29, 162, 240, 1.0),
    brightness: Brightness.light,
    primaryColor: Color(0xff1DA1F2),
    cardColor: Colors.white,
    unselectedWidgetColor: Colors.grey,
    bottomAppBarColor: Colors.white,
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Color(0xFFffffff)),
    inputDecorationTheme: inputDecorationTheme(),
    appBarTheme: AppBarTheme(
        brightness: Brightness.light,
        color: Color.fromRGBO(255, 255, 255, 1.0),
        iconTheme: IconThemeData(
          color: Color.fromRGBO(29, 162, 240, 1.0),
        ),
        elevation: 0,
        textTheme: TextTheme(
          headline5: TextStyle(
              color: Colors.black, fontSize: 26, fontStyle: FontStyle.normal),
        )),
    tabBarTheme: TabBarTheme(
      labelStyle: titleStyle.copyWith(color: Color.fromRGBO(29, 162, 240, 1.0)),
      unselectedLabelColor: Color(0xff1657786),
      unselectedLabelStyle: titleStyle.copyWith(color: Color(0xff1657786)),
      labelColor: Color.fromRGBO(29, 162, 240, 1.0),
      labelPadding: EdgeInsets.symmetric(vertical: 12),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color.fromRGBO(29, 162, 240, 1.0),
    ),
    colorScheme: ColorScheme(
        background: Colors.white,
        onPrimary: Colors.white,
        onBackground: Colors.black,
        onError: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.black,
        error: Colors.red,
        primary: Colors.blue,
        primaryVariant: Colors.blue,
        secondary: Color(0xff14171A),
        secondaryVariant: Color(0xff1657786),
        surface: Colors.white,
        brightness: Brightness.light),
  );
}

TextStyle get titleStyle {
  return TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}

InputDecorationTheme inputDecorationTheme() {
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(color: kTextColor),
      gapPadding: 10,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(color: kTextColor),
      gapPadding: 10,
    ),
  );
}
