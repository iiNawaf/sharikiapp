import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';

class PosterMajor extends StatelessWidget {
  const PosterMajor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('./assets/icons/asterisk.png'),
        SizedBox(width: 5),
        Text(
          "مبرمج تطبيقات",
          style: TextStyle(
              color: primaryColor, fontSize: 13, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
