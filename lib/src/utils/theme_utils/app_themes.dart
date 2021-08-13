import 'package:flutter/material.dart';

enum AppTheme {
  GreenLight,
  GreenDark,
  OrangeLight,
  OrangeDark,
}

final appThemeData = {
  AppTheme.GreenLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: Color.fromRGBO(90, 0, 132, 1),
  ),
  AppTheme.GreenDark: ThemeData(
    brightness: Brightness.light,
    primaryColor: Color.fromRGBO(0, 143, 48, 1.0),
  ),
  AppTheme.OrangeLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: Color.fromRGBO(249, 196, 12, 1.0),
  ),
  AppTheme.OrangeDark: ThemeData(
    brightness: Brightness.light,
    primaryColor: Color.fromRGBO(240, 152, 30, 1.0),
  ),
};
