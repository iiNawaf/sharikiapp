import 'package:flutter/material.dart';
import 'package:sharikiapp/styles/constant_styles.dart';

class SubmitButton extends StatelessWidget {
  String title;
  Function() submit;
  SubmitButton({required this.title, required this.submit});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: submit,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(10)
            ),
        child: Center(child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: whiteColor),)),
      ),
    );
  }
}
