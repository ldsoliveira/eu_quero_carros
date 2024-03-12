import 'package:flutter/material.dart';

class CustomAppTheme {
  static ThemeData appTheme() {
    return ThemeData(
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        backgroundColor: Colors.yellow[400],
      ),
      cardTheme: CardTheme(
        color: Colors.yellow[50],
        shadowColor: Colors.yellow[300],
        surfaceTintColor: Colors.yellow[50],
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: Colors.yellow[600],
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          alignment: Alignment.center,
          textStyle: MaterialStateProperty.all(TextStyle(
            color: Colors.grey[600]
          )),
          side: MaterialStateProperty.all(BorderSide(
            color: Colors.grey[600] ?? Colors.grey)),
          foregroundColor: MaterialStateProperty.all(Colors.grey[600]),
        )
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        labelStyle: TextStyle(color: Colors.black),
        hoverColor: Colors.black,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          alignment: Alignment.center,
          iconColor: MaterialStateProperty.all(Colors.black),
          textStyle: MaterialStateProperty.all(const TextStyle(
            color: Colors.black
          )),
          backgroundColor: MaterialStateProperty.all(Colors.yellow[300]),
          foregroundColor: MaterialStateProperty.all(Colors.black),
        ),
      ),
    );
  }
}