import 'package:flutter/material.dart';
import 'package:sharikiapp/styles/constant_styles.dart';

class ButtonLoading extends StatelessWidget {
  const ButtonLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: primaryColor),
    );
  }
}