import 'package:flutter/material.dart';
import 'package:sharikiapp/styles/constant_styles.dart';

class PostImage extends StatelessWidget {
  double height;
  double width;
  String img;
  PostImage({required this.height, required this.width, required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(img)
        ),
          color: bgColor, borderRadius: BorderRadius.circular(10)),
    );
  }
}
