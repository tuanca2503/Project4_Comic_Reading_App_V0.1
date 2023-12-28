import 'package:flutter/cupertino.dart';

enum BodyPaddingType { horizontal, horizontalTop, all, zero }

class AppDimension {
  AppDimension._();

  static late BoxConstraints baseConstraints;

  // margin, padding
  static const double dimension4 = 4;
  static const double dimension8 = 8;
  static const double dimension12 = 12;
  static const double dimension16 = 16;
  static const double dimension24 = 24;
  static const double dimension32 = 32;
  static const double dimension64 = 64;
  static const double dimension128 = 128;

  // radius
  static const double radius12 = 12;
  static const double radius16 = 16;
  static const double radius24 = 24;

  static EdgeInsets initPaddingBody(
      {BodyPaddingType bodyPaddingType = BodyPaddingType.horizontal}) {
    switch (bodyPaddingType) {
      case BodyPaddingType.horizontal:
        return EdgeInsets.symmetric(
            horizontal: AppDimension.baseConstraints.maxWidth * 0.05);
      case BodyPaddingType.all:
        return EdgeInsets.symmetric(
            horizontal: AppDimension.baseConstraints.maxWidth * 0.05,
            vertical: AppDimension.baseConstraints.maxHeight * 0.01);
      case BodyPaddingType.horizontalTop:
        return EdgeInsets.only(
            left : AppDimension.baseConstraints.maxWidth * 0.05,
            right : AppDimension.baseConstraints.maxWidth * 0.05,
            top: AppDimension.baseConstraints.maxHeight * 0.01);
      case BodyPaddingType.zero:
        return EdgeInsets.zero;
    }
  }
}
