import 'package:project4/utils/app_dimension.dart';

class AppFontSize {
  AppFontSize._();

  static double get headline1 => AppDimension.baseConstraints.maxHeight * 0.05;
  static double get headline2 => AppDimension.baseConstraints.maxHeight * 0.04;
  static double get headline3 => AppDimension.baseConstraints.maxHeight * 0.03;
  static double get headline4 => AppDimension.baseConstraints.maxHeight * 0.025;

  static double get button => AppDimension.baseConstraints.maxHeight * 0.027;

  static double get body => AppDimension.baseConstraints.maxHeight * 0.025;
  static double get bodySmall => AppDimension.baseConstraints.maxHeight * 0.022;
  static double get label => AppDimension.baseConstraints.maxHeight * 0.02;
  static double get labelSmall => AppDimension.baseConstraints.maxHeight * 0.17;

}