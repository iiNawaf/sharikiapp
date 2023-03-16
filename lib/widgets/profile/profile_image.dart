import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sharikiapp/styles/constant_styles.dart';

class ProfileImage extends StatelessWidget {
  ImageProvider<Object> image;
  ProfileImage({required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              color: bgColor,
              image: DecorationImage(
                image: image,
                fit: BoxFit.scaleDown,
              ),
              borderRadius: BorderRadius.all(Radius.circular(60.0)),
              border: Border.all(
                color: primaryColor,
                width: 3.0,
              ),
            ),
          );
  }
}
