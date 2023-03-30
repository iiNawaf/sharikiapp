import 'package:flutter/material.dart';
import 'package:sharikiapp/styles/constant_styles.dart';

ThemeData defaultTheme = ThemeData(
  fontFamily: 'Cairo',
  primaryColor: primaryColor,
  scaffoldBackgroundColor: bgColor,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  iconTheme: IconThemeData(color: textColor),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: subTextColor
      ),
  ),
  textTheme: TextTheme(
    titleMedium: TextStyle(
      color: textColor,
      fontSize: 16,
      fontWeight: FontWeight.bold
    ),
    titleSmall: TextStyle(
      color: primaryColor,
      fontSize: 14,
      fontWeight: FontWeight.bold
    ),
    bodyMedium: TextStyle(
      color: subTextColor,
      fontSize: 14,
    ),
    bodySmall: TextStyle(
      color: subTextColor,
      fontSize: 12,
    ),
  ),
);
