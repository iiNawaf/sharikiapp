import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';

class PostRequiredJob extends StatelessWidget {
  String major;
  PostRequiredJob({required this.major});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('./assets/icons/asterisk.png'),
        SizedBox(width: 5),
        Text(
          major,
          style: TextStyle(
              color: primaryColor, fontSize: 13, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
