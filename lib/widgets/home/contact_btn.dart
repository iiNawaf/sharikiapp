import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';

class ContactBtn extends StatelessWidget {
  String iconPath;
  ContactBtn({required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 65,
        width: 65,
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(10)),
        child: Image.asset(iconPath),
      ),
    );
  }
}
