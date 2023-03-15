import 'package:flutter/material.dart';
import 'package:sharikiapp/utilities/styles/constant_styles.dart';

class FetchingDataLoading extends StatelessWidget {
  static GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: primaryColor),
      ),
    ),
    );
  }
}
