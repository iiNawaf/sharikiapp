import 'package:flutter/material.dart';
import 'package:sharikiapp/styles/constant_styles.dart';

class TimelinePostImage extends StatelessWidget {
  const TimelinePostImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: primaryColor)
        ),
      height: 50,
      width: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('./assets/images/shariki_logo.png'),
      )
    );
  }
}
