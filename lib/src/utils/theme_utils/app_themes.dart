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
    primaryColor: Color.fromRGBO(20, 137, 54, 1),
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
    primaryColor: Color.fromRGBO(247, 121, 34, 1),
  ),
};
