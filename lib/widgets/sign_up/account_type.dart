import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';

class AccountType extends StatelessWidget {
  String imgPath;
  String title;
  Color borderColor;
  Function() chooseAccount;

  AccountType(
      {required this.imgPath,
      required this.title,
      required this.borderColor,
      required this.chooseAccount});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: chooseAccount,
      child: Container(
        padding: EdgeInsets.only(left: 50, right: 50),
        height: 180,
        // width: 180,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor, width: 2),
            color: whiteColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imgPath),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
