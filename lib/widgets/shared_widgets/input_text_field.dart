import 'package:flutter/material.dart';
import 'package:sharikiapp/styles/constant_styles.dart';

class InputTextField extends StatelessWidget {
  String title;
  bool isObsecure;
  TextEditingController controller;
  int maxLines;
  int maxLength;
  TextInputType inputType;
  InputTextField(
      {required this.title,
      required this.isObsecure,
      required this.controller,
      required this.maxLines,
      required this.maxLength,
      required this.inputType});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: maxLines == 1
          ? 60
          : maxLines == 2
              ? 90
              : 120,
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: TextFormField(
          keyboardType: inputType,
          maxLength: maxLength,
          minLines: 1,
          maxLines: maxLines,
          controller: controller,
          obscureText: isObsecure,
          decoration: InputDecoration(
            counterText: "",
              border: InputBorder.none,
              hintText: title,
              hintStyle: TextStyle(color: inputTextColor)),
        ),
      ),
    );
  }
}
