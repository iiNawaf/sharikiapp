import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';

class PosterTime extends StatelessWidget {
  const PosterTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "منذ ساعة",
      style: TextStyle(
          color: subTextColor, fontSize: 12, fontWeight: FontWeight.bold),
    );
  }
}
