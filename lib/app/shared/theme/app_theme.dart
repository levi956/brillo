import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightThemeData = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Colors.black,
    brightness: Brightness.light,
    fontFamily: 'ProductSans',
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        fontFamily: 'ProductSans',
        fontSize: 14,
      ),
    ),
  );
}
