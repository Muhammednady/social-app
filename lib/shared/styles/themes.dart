import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
    textTheme: TextTheme(
      bodyLarge: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w900, color: Colors.black),
      bodyMedium: TextStyle(fontSize: 16,fontWeight: FontWeight.w600, color: Colors.black),
      bodySmall: TextStyle(fontSize: 16, color: Colors.grey),
      displaySmall: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color: Colors.black),
      displayMedium: TextStyle(fontSize: 12,fontWeight: FontWeight.bold, color: Colors.grey)  
  
    ),
    fontFamily: 'myfont',
    primarySwatch: Colors.blue,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: defaultColor,
        unselectedItemColor: Colors.grey,
        elevation: 20.0,
        showUnselectedLabels: true),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        //statusBarBrightness: Brightness.light,
      ),
      iconTheme: IconThemeData(color: Colors.black),
      titleSpacing: 10.0,
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w900),
      color: Colors.white,
      elevation: 0.0,
    ));

ThemeData darkTheme = ThemeData(
    textTheme: TextTheme(
      bodyLarge: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 18, color: Colors.grey),
      bodySmall: TextStyle(fontSize: 16.0, color: Colors.grey),
    ),
    fontFamily: 'myfont',
    primarySwatch: defaultColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: HexColor('333734'),
        selectedItemColor: defaultColor,
        unselectedItemColor: Colors.grey,
        elevation: 20.0,
        showUnselectedLabels: true),
    scaffoldBackgroundColor: HexColor('333734'),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333734'),
        statusBarIconBrightness: Brightness.light,
        //statusBarBrightness: Brightness.light,
      ),
      iconTheme: IconThemeData(color: Colors.white),
      titleSpacing: 10.0,
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w900),
      color: HexColor('333734'),
      elevation: 0.0,
    ));

