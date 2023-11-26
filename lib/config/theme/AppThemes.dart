import 'package:flutter/material.dart';
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  hintColor: const Color(0xFF542BBA),
  scaffoldBackgroundColor: Colors.black,
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), // Adjust text style as needed
    bodyText2: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), // Adjust text style as needed
  ),
  // other properties...
);
Color darkGray = Color(0xFF333333);
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  hintColor: const Color(0xFF542BBA),
  scaffoldBackgroundColor: Colors.black,
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), // Adjust text style as needed
    bodyText2: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), // Adjust text style as needed
  ),
  // other properties...
);

AppBarTheme appBarTheme() {
 return const AppBarTheme(
   color: Colors.white ,
   elevation: 5 ,
   centerTitle: true ,
   iconTheme: IconThemeData(color: Color(0XFF8B8B8B)),
   titleTextStyle: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
 );
}