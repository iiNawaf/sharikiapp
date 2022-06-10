import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';

class SharedAppBar extends StatelessWidget {
  String title;
  SharedAppBar({required this.title});
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(title, style: TextStyle(color: textColor, fontSize: 18)),
      leading: Image.asset('./assets/icons/menu.png'),
      actions: [
        Image.asset('./assets/icons/notification.png')
      ],
    );
  }
}