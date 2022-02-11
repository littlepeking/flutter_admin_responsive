import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EhTheme {
  static Transition defaultTransition = Transition.zoom;

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      //    primaryColor: Colors.amber,
      buttonTheme: ButtonThemeData(
          // buttonColor: Colors.amber,
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
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.grey[400]!,
        disabledColor: Colors.grey,
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
