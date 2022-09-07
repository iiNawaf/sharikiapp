import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';

class PostImage extends StatelessWidget {
  double height;
  double width;
  PostImage({required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(10)),
    );
  }
}