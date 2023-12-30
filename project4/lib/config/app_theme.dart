import 'package:flutter/material.dart';
import 'package:project4/config/app_color.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    hintColor: AppColor.lightTheme[AppColorField.hint]!,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.lightTheme[AppColorField.background]!,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColor.lightTheme[AppColorField.onBackground]!),
      titleTextStyle: TextStyle(color: AppColor.lightTheme[AppColorField.onBackground]!),
    ),
    colorScheme: ColorScheme.light(
      background: AppColor.lightTheme[AppColorField.background]!,
      surface: AppColor.lightTheme[AppColorField.surface]!,
      surfaceVariant: AppColor.lightTheme[AppColorField.surfaceVariant]!,
      primary: AppColor.lightTheme[AppColorField.primary]!,
      secondary: AppColor.lightTheme[AppColorField.secondary]!,
      tertiary: AppColor.lightTheme[AppColorField.tertiary]!,
      outline: AppColor.lightTheme[AppColorField.outline]!,
      onBackground: AppColor.lightTheme[AppColorField.onBackground]!,
      onSurface: AppColor.lightTheme[AppColorField.onBackground]!,
      onPrimary: AppColor.lightTheme[AppColorField.background]!,
      onSecondary: AppColor.lightTheme[AppColorField.background]!,
      onTertiary: AppColor.lightTheme[AppColorField.onBackground]!,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        unselectedItemColor: AppColor.lightTheme[AppColorField.onBackground]!
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColor.lightTheme[AppColorField.fillField]!,
      hintStyle: TextStyle(
        color: AppColor.lightTheme[AppColorField.hint]!,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColor.lightTheme[AppColorField.outline]!,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColor.lightTheme[AppColorField.focus]!,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColor.error,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColor.error,
          width: 2,
        ),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColor.lightTheme[AppColorField.onBackground]!,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    hintColor: AppColor.darkTheme[AppColorField.hint]!,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.darkTheme[AppColorField.background]!,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColor.darkTheme[AppColorField.onBackground]!),
      titleTextStyle: TextStyle(color: AppColor.darkTheme[AppColorField.onBackground]!),
    ),
    colorScheme: ColorScheme.dark(
      background: AppColor.darkTheme[AppColorField.background]!,
      surface: AppColor.darkTheme[AppColorField.surface]!,
      surfaceVariant: AppColor.darkTheme[AppColorField.surfaceVariant]!,
      primary: AppColor.darkTheme[AppColorField.primary]!,
      secondary: AppColor.darkTheme[AppColorField.secondary]!,
      tertiary: AppColor.darkTheme[AppColorField.tertiary]!,
      outline: AppColor.darkTheme[AppColorField.outline]!,
      onBackground: AppColor.darkTheme[AppColorField.onBackground]!,
      onSurface: AppColor.darkTheme[AppColorField.onBackground]!,
      onPrimary: AppColor.darkTheme[AppColorField.background]!,
      onSecondary: AppColor.darkTheme[AppColorField.background]!,
      onTertiary: AppColor.darkTheme[AppColorField.onBackground]!,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        unselectedItemColor: AppColor.darkTheme[AppColorField.onBackground]!
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColor.darkTheme[AppColorField.fillField]!,
      hintStyle: TextStyle(
        color: AppColor.darkTheme[AppColorField.hint]!,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColor.darkTheme[AppColorField.outline]!,
          width: 1,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColor.darkTheme[AppColorField.outline]!,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColor.darkTheme[AppColorField.focus]!,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColor.error,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColor.error,
          width: 2,
        ),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColor.darkTheme[AppColorField.onBackground]!,
    ),
  );
}


