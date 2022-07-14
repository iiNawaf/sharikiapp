import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';

class PostCity extends StatelessWidget {
  String city;
  PostCity({required this.city});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('./assets/icons/location.png'),
        SizedBox(width: 2),
        Text(city,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: subTextColor)),
      ],
    );
  }
}
