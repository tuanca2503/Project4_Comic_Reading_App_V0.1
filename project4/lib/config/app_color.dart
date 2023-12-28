import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AppColorField {
  onBackground,
  background,
  primary,
  secondary,
  tertiary,
  surface,
  surfaceVariant,
  hint,
  fillField,
  outline,
  focus,
}

class AppColor {
  AppColor._();

  static MaterialColor _createMaterialColor(Color color) {
    return MaterialColor(color.value, <int, Color>{
      50: Color.fromRGBO(color.red, color.green, color.blue, .05),
      100: Color.fromRGBO(color.red, color.green, color.blue, .1),
      200: Color.fromRGBO(color.red, color.green, color.blue, .2),
      300: Color.fromRGBO(color.red, color.green, color.blue, .3),
      400: Color.fromRGBO(color.red, color.green, color.blue, .4),
      500: Color.fromRGBO(color.red, color.green, color.blue, .5),
      600: Color.fromRGBO(color.red, color.green, color.blue, .6),
      700: Color.fromRGBO(color.red, color.green, color.blue, .7),
      800: Color.fromRGBO(color.red, color.green, color.blue, .8),
      900: Color.fromRGBO(color.red, color.green, color.blue, .9),
    });
  }

  static Map<AppColorField, Color> _createTheme(
  {required MaterialColor onBackground,
    required MaterialColor background,
    required MaterialColor primary,
    required MaterialColor secondary,
    required MaterialColor tertiary}) {
    return <AppColorField, Color>{
      AppColorField.onBackground: onBackground,
      AppColorField.background: background,
      AppColorField.primary: primary,
      AppColorField.secondary: secondary,
      AppColorField.tertiary: tertiary,
      AppColorField.surface: secondary[100]!,
      AppColorField.surfaceVariant: secondary[300]!,
      AppColorField.hint: onBackground[200]!,
      AppColorField.fillField: secondary[200]!,
      AppColorField.outline: secondary[400]!,
      AppColorField.focus: onBackground[500]!,
    };
  }

  static Color getColorByMode({required BuildContext context, required AppColorField field, double opacity = 1}) {
    if (context.isDarkMode) darkTheme[field]!.withOpacity(opacity);
    return lightTheme[field]!.withOpacity(opacity);
  }


  static final darkTheme = _createTheme(
      onBackground: _createMaterialColor(const Color(0xfff0f0f0)),
      background: _createMaterialColor(const Color(0xFF191919)),
      primary: _createMaterialColor(const Color(0xFFD29E0F)),
      secondary: _createMaterialColor(const Color(0xff503DE1)),
      tertiary: _createMaterialColor(const Color(0xff47EBE8)));

  static final lightTheme = _createTheme(
      onBackground: _createMaterialColor(const Color(0xff0F0F0F)),
      background: _createMaterialColor(const Color(0xFFE6E6E6)),
      primary: _createMaterialColor(const Color(0xFFF0BC2C)),
      secondary: _createMaterialColor(const Color(0xff311EC4)),
      tertiary: _createMaterialColor(const Color(0xff15B8B6)));

  static Color error = const Color(0xffBF3131);
  static Color success = const Color(0xff4F6F52);
  static Color overlay = Colors.black.withOpacity(0.7);
  static Color overlayActive = Colors.black.withOpacity(0.4);
  static Color onOverlay = Colors.white.withOpacity(0.8);
  static Color transparent = Colors.transparent;
}
