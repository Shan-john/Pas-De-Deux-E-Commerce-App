import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData themeData = ThemeData(
  splashColor: Colors.transparent,
  appBarTheme: AppBarTheme(
    
    iconTheme: IconThemeData(
      weight: 18,
      color: HexColor("#242628"),
    ),
    titleTextStyle: const TextStyle(
      color:Colors.white,
      fontSize: 23,
      fontWeight: FontWeight.bold,
    ),
    elevation: 0,
    color: const Color.fromARGB(
      255,
      240,
      239,
      237,
    ),
  ),
 // primaryColor:  Color.fromARGB(255, 170, 22, 12),
 primaryColor: const Color.fromARGB(248, 179, 21, 21),
  inputDecorationTheme: InputDecorationTheme(
  
  labelStyle: const  TextStyle( color: Colors.white ),
    hintStyle: const TextStyle(color: Color.fromARGB(153, 255, 255, 255)),
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    border: outlineInputBorder,
    errorBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    disabledBorder: outlineInputBorder,
    enabledBorder: outlineInputBorder,
  ),
  
  scaffoldBackgroundColor: HexColor("#242628"),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 15,
      backgroundColor: const  Color.fromARGB(106, 6, 4, 112),
     // backgroundColor: Color.fromARGB(255, 170, 22, 12),
      disabledBackgroundColor: Colors.grey,
      textStyle: const TextStyle(
        fontSize: 18,
      ),
    ),
  ),
  buttonTheme:const ButtonThemeData(
    splashColor:  Colors.transparent,
  ),
);
OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: const BorderRadius.all(
    Radius.circular(
      50,
    ),
  ),
  borderSide: BorderSide(
    color:   HexColor("#343537"), 
  ),
);
