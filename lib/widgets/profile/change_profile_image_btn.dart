import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';


class ChangeProfileImageBtn extends StatelessWidget {
  const ChangeProfileImageBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 100,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(5)
      ),
      child: Center(
        child: Text("تغيير", style: TextStyle(color: whiteColor, fontWeight: FontWeight.bold, fontSize: 13),),
      ),
    );
  }
}