import 'package:flutter/material.dart';
import 'package:sharikiapp/styles/constant_styles.dart';


class PostDescription extends StatelessWidget {
  TextOverflow overflow;
  String description;
  PostDescription({required this.overflow, required this.description});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        description,
         style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: subTextColor),
         overflow: overflow,),
    );
  }
}