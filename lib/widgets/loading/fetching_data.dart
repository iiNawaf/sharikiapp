import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';
class FetchingDataLoading extends StatelessWidget {
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Center(
        child: CircularProgressIndicator(color: primaryColor),
      ),
    );
  }
}