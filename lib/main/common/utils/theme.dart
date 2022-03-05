import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EhTheme {
  static Transition defaultTransition = Transition.zoom;

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      //    primaryColor: Colors.amber,
      textTheme: TextTheme(
        bodyText1: TextStyle(fontSize: 13),
        bodyText2: TextStyle(fontSize: 13),
        button: TextStyle(fontSize: 13),
        subtitle1: TextStyle(fontSize: 13),
        headline3: TextStyle(fontSize: 18),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.black,

        // disabledColor: Colors.grey,
      ),
      checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          fillColor: MaterialStateProperty.all(Colors.grey),
          checkColor: MaterialStateProperty.all(Colors.white)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            primary: Colors.grey[900]!,
            side: BorderSide(
              width: 1.0,
              color: Colors.grey[600]!,
            )),
        // disabledColor: Colors.grey,
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: _buildBorder(Colors.grey[600]!),
        focusedBorder: _buildBorder(Colors.white),
        errorBorder: _buildBorder(Colors.red),
        disabledBorder: _buildBorder(Colors.grey[400]!),
      ),
      textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.white));

  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.grey,
      textTheme: TextTheme(
        bodyText1: TextStyle(fontSize: 13),
        bodyText2: TextStyle(fontSize: 13),
        button: TextStyle(fontSize: 13),
        subtitle1: TextStyle(fontSize: 13),
        headline3: TextStyle(fontSize: 18),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.grey[400]!,
        disabledColor: Colors.grey,
      ),
      checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(Colors.grey[900]!),
          checkColor: MaterialStateProperty.all(Colors.white)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.black,
            side: BorderSide(
              width: 1.0,
              color: Colors.black,
            )),
        // disabledColor: Colors.grey,
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: _buildBorder(Colors.grey[600]!),
        focusedBorder: _buildBorder(Colors.grey),
        // errorBorder: _buildBorder(Colors.red),
        disabledBorder: _buildBorder(Colors.grey[400]!),
      ));

  static _buildBorder(Color color) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: color, width: 1));
  }
}
