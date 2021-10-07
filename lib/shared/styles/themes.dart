import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
Color? defaultColor = HexColor('#1DBCB8');
ThemeData? lightTheme = ThemeData(
   // fontFamily: 'spartman',
    textTheme: TextTheme(

        bodyText1: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: Colors.white)),
    primaryColor: defaultColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: defaultColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor),
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          fontFamily: 'spartman',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0,
        backgroundColor: Colors.white));