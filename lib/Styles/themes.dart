import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/Styles/Colors/colors.dart';

ThemeData darktheme = ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),
  primarySwatch: Colors.deepOrange,
  appBarTheme: AppBarTheme(
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light,
      ),
      iconTheme: IconThemeData(
        color: Colors.grey,
      ),
      backgroundColor: HexColor('333739'),
      elevation: 10.0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      )),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
  ),
  iconTheme: IconThemeData(
    color: Colors.grey,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    backgroundColor: HexColor('333739'),
    unselectedItemColor: Colors.grey,
    elevation: 50,
  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  )),
);
const primaryColorMid = Color(0xF38E8E);

ThemeData lighttheme = ThemeData(
  scaffoldBackgroundColor: HexColor('ffffff'),
  primarySwatch: Colors.pink,

  appBarTheme: AppBarTheme(
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('ffffff'),
        statusBarIconBrightness: Brightness.light,
      ),
      iconTheme: const IconThemeData(
        color: Colors.grey,
      ),
      backgroundColor: HexColor('ffffff'),
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      )),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: defaultcolor,
  ),
 iconTheme : IconThemeData(
    color: Colors.grey,

  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    backgroundColor: HexColor('333739'),
    unselectedItemColor: Colors.grey,
    elevation: 50,
  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: HexColor('F38E8E'),
  )),
);
