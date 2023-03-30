import 'package:flutter/material.dart';
import 'package:sharikiapp/widgets/shared_widgets/shared_alert_dialog.dart';

void showAlertDialog(context, bool isDismissible, String title, dynamic content, String btnTitle,
    String btnTitle2, Function() click, Function() click2) {
  showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (context) {
        return SharedAlertDialog(
            title: title,
            content: content,
            btnTitle: btnTitle,
            btnTitle2: btnTitle2,
            click: click,
            click2: click2);
      });
}
