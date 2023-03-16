import 'package:flutter/material.dart';

void navigateTo(context, Widget target) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => target));
}

void navigateBack(context) {
  Navigator.pop(context);
}

void navigateToFirst(context) {
  Navigator.popUntil(context, (route) => route.isFirst);
}
