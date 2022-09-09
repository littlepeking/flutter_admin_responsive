import 'package:flutter/material.dart';
import 'package:get/get.dart';


class EhTheme {
  static Transition defaultTransition = Transition.zoom;

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.white,
      backgroundColor: Colors.black,
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
            backgroundColor: Colors.grey[900]!,
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
        disabledBorder: _buildBorder(Colors.grey[800]!),
      ),
      textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.white,
          selectionColor: Color.fromARGB(255, 95, 95, 95)));

  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.grey,
      backgroundColor: Colors.white,
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          fillColor: MaterialStateProperty.all(Colors.grey[900]!),
          checkColor: MaterialStateProperty.all(Colors.white)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black, backgroundColor: Colors.white,
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
      ),
      textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.grey,
          selectionColor: Color.fromARGB(255, 200, 199, 199)));

  static _buildBorder(Color color) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: color, width: 1));
  }
}
