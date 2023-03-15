import 'package:flutter/material.dart';
import 'package:sharikiapp/utilities/styles/constant_styles.dart';

class PostTime extends StatelessWidget {
  String time;
  PostTime({required this.time});
  @override
  Widget build(BuildContext context) {
    return Text(
      time,
      style: TextStyle(
          color: subTextColor, fontSize: 12, fontWeight: FontWeight.bold),
    );
  }
}
