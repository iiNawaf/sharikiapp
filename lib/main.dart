import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sharikiapp/screens/app_manager.dart';
import 'package:sharikiapp/screens/login/login.dart';
import 'package:sharikiapp/styles.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("ar", "AE"),
      ],
      theme: ThemeData(
        fontFamily: 'Cairo',
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: AppManager(),
    );
  }
}