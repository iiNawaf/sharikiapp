import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';

class PosterImage extends StatelessWidget {
  const PosterImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(10)),
    );
  }
}
