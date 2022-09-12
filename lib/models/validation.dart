import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';

class Validation {
  //Regex
  static final RegExp nameRegex = RegExp('^[a-zA-Z]');
  static final RegExp phoneNumberRegex = RegExp('^05[0-9]');

  //functions
  static bool isEmpty(String text) {
    if (text.isEmpty) {
      return true;
    }
    return false;
  }

  static bool nameValidation(String text) {
    if (nameRegex.hasMatch(text) || text.length > 20) {
      return true;
    }
    return false;
  }

  static bool emailValidation(String text) {
    if (EmailValidator.validate(text)) {
      return true;
    }
    return false;
  }

  static bool phoneNumberValidation(String text) {
    if (phoneNumberRegex.hasMatch(text) || text.length != 10) {
      return true;
    }
    return false;
  }
  
  //Error messages
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> bottomMsg(
      BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: "حسنًا",
          textColor: primaryColor,
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar,
        ),
      ),
    );
  }
}
