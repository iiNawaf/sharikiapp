import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';

class ProfileImage extends StatelessWidget {
  String imgPath;
  ProfileImage({required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 130,
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(100)),
      child: Center(
        child: imgPath == ""
        ? Image.asset('./assets/icons/individual.png') 
        : Text("Img"),
      ),
    );
  }
}
