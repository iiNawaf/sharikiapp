import 'package:flutter/material.dart';
import 'package:sharikiapp/utilities/styles/constant_styles.dart';


class ChangeProfileImageBtn extends StatelessWidget {
  Function() pickImage;
  ChangeProfileImageBtn({required this.pickImage});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pickImage,
      child: Container(
        height: 30,
        width: 100,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(5)
        ),
        child: Center(
          child: Text("تغيير", style: TextStyle(color: whiteColor, fontWeight: FontWeight.bold, fontSize: 13),),
        ),
      ),
    );
  }
}