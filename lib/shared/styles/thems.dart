import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/shared/styles/colors.dart';

ThemeData darkThem = ThemeData(
    focusColor: Colors.white,
    scaffoldBackgroundColor: backgroundColor,
    primarySwatch: Colors.deepOrange,
    appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(
            color: Colors.white
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: backgroundColor,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: backgroundColor,
        elevation: 0.0,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        )
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
      elevation: 200.0,
      backgroundColor: backgroundColor,
    ),
    textTheme: const TextTheme(
        bodyMedium : TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Colors.white
        )
    ),
    fontFamily: 'Janna',
);

ThemeData lightThem = ThemeData(
  focusColor: Colors.black,
  textTheme: const TextTheme(
      bodyMedium : TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.black
      )
  ),
  primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
          color: Colors.black
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,

      )
  ),
  floatingActionButtonTheme:  FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primaryColor,
      elevation: 200.0
  ),
  fontFamily: 'Janna',
);