import 'package:flutter/material.dart';
import 'package:sharikiapp/styles/constant_styles.dart';

class PostTitle extends StatelessWidget {
  String title;
  PostTitle({required this.title});
  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: subTextColor),);
  }
}