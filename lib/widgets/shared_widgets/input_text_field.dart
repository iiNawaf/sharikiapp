import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';

class InputTextField extends StatelessWidget {
  String title;
  bool isObsecure;
  TextEditingController controller;
  int maxLines;
  InputTextField({required this.title, required this.isObsecure, required this.controller, required this.maxLines});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: maxLines == 1 ? 60 : maxLines == 2 ? 90 : 120,
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: TextField(
          minLines: 1,
          maxLines: maxLines,
          controller: controller,
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
