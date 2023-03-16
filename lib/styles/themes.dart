import 'package:flutter/material.dart';
import 'package:sharikiapp/styles/constant_styles.dart';

ThemeData defaultTheme = ThemeData(
  fontFamily: 'Cairo',
  primaryColor: primaryColor,
  scaffoldBackgroundColor: bgColor,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  iconTheme: IconThemeData(color: textColor),
  textTheme: TextTheme(
    // Title style
    titleMedium: TextStyle(
      color: textColor,
      fontSize: 16,
      fontWeight: FontWeight.bold
    ),
    // More button style
    titleSmall: TextStyle(
      color: primaryColor,
      fontSize: 14,
      fontWeight: FontWeight.bold
    ),
  )
);
