import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';

class PosterCity extends StatelessWidget {
  const PosterCity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('./assets/icons/location.png'),
        SizedBox(width: 2),
        Text("الرياض",
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: subTextColor)),
      ],
    );
  }
}
