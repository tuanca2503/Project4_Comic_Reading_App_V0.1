import 'package:flutter/material.dart';

class ThemeApp {
  static const Color _lightBackgroundColor = Colors.transparent;
  static final Color _lightPrimaryColor = Colors.grey[200]!;
  static final Color _lightSecondaryColor = Colors.grey[300]!;

  static const Color _darkBackgroundColor = Colors.black;
  static final Color _darkPrimaryColor = Colors.grey[900]!;
  static final Color _darkSecondaryColor = Colors.grey[800]!;

  static ThemeData darkTheme = ThemeData(
    primaryColor: ThemeData.dark().scaffoldBackgroundColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: _darkBackgroundColor),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: _darkPrimaryColor,
      secondary: _darkSecondaryColor,
    )
  );

  static ThemeData lightTheme = ThemeData(
      primaryColor: ThemeData.dark().scaffoldBackgroundColor,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: _lightBackgroundColor),
      colorScheme: const ColorScheme.dark().copyWith(
        primary: _lightPrimaryColor,
        secondary: _lightSecondaryColor,
      )
  );
}
