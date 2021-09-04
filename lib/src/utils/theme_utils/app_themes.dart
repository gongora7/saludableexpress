import 'package:flutter/material.dart';
import 'dart:ui';

enum AppTheme {
  GreenLight,
  GreenDark,
  OrangeLight,
  OrangeDark,
  EEVLight,
  EEVDark,
}

final appThemeData = {
  AppTheme.EEVLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: Color.fromRGBO(255, 88, 56, 1),
  ),
  AppTheme.EEVDark: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Color.fromRGBO(58, 58, 58, 1),
      canvasColor: Color.fromRGBO(50, 45, 56, 1)),
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
