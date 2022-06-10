import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';

class InputTextField extends StatelessWidget {
  String title;
  bool isObsecure;
  InputTextField({required this.title, required this.isObsecure});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: TextField(
          obscureText: isObsecure,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: title,
              hintStyle: TextStyle(
                  color: inputTextColor)),
        ),
      ),
    );
  }
}
