import 'package:BalanceFlow/utils/constants.dart';
import 'package:flutter/material.dart';

//====Colors=====

//  light theme colors
const Color lightPrimaryColor = Colors.blue;
const Color lightSecondaryColor = Colors.blueAccent;
//  dark theme colors
const Color darkPrimaryColor = Colors.blueGrey;
const Color darkSecondaryColor = Colors.grey;


//====Theme=====

// bodySmall: 12px  caption
// labelLarge: 14px  button
// bodyMedium: 16px
// bodyLarge: 18px
// displayLarge: 24px


//  light theme Text
const TextTheme lightTextTheme = TextTheme(
  bodySmall:TextStyle( fontFamily: openSansFont,fontWeight: FontWeight.normal, color: Colors.black54, fontSize: 12) ,
  labelLarge: TextStyle(fontFamily: openSansFont,fontWeight: FontWeight.bold,color: Colors.white, fontSize: 14),
  bodyMedium:TextStyle(fontFamily: openSansFont,fontWeight: FontWeight.normal, color: Colors.black, fontSize: 16) ,
  bodyLarge: TextStyle(fontFamily: openSansFont,fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
  displayLarge: TextStyle(fontFamily: openSansFont,fontWeight: FontWeight.bold,color: Colors.black, fontSize: 24),
  // titleLarge: TextStyle(fontFamily: openSansFont,fontWeight: FontWeight.bold,color: Colors.black, fontSize: 28),
);

//  dark theme Text
const TextTheme darkTextTheme = TextTheme(
  bodySmall:TextStyle(fontFamily: openSansFont,fontWeight: FontWeight.normal, color: Colors.white70, fontSize: 12) ,
  labelLarge: TextStyle(fontFamily: openSansFont,fontWeight: FontWeight.bold,color: Colors.black, fontSize: 14),
  bodyMedium:TextStyle(fontFamily: openSansFont,fontWeight: FontWeight.normal, color: Colors.white, fontSize: 16) ,
  bodyLarge: TextStyle(fontFamily: openSansFont,fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
  displayLarge: TextStyle(fontFamily: openSansFont,fontWeight: FontWeight.bold,color: Colors.white, fontSize: 24),
  // titleLarge: TextStyle(fontFamily: openSansFont,fontWeight: FontWeight.bold,color: Colors.white, fontSize: 28),

);


//   Light theme
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: lightPrimaryColor,
  hintColor: lightSecondaryColor,
  textTheme: lightTextTheme,
);

//   Dark theme
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: darkPrimaryColor,
  hintColor: darkSecondaryColor,
  textTheme:  darkTextTheme
);
//


