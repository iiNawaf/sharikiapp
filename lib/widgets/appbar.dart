import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';

class SharedAppBar extends StatelessWidget {
  String title;
  bool isAppManager;
  SharedAppBar({required this.title, required this.isAppManager});
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromRGBO(0, 0, 0, 0),
      elevation: 0,
      iconTheme: IconThemeData(color: textColor),
      centerTitle: true,
      title: Text(title, style: TextStyle(color: textColor, fontSize: 18)),
      leading: isAppManager == true ? Image.asset('./assets/icons/menu.png') : null,
      actions: [
        isAppManager == true 
        ? Image.asset('./assets/icons/notification.png') 
        : Container()
      ],
    );
  }
}