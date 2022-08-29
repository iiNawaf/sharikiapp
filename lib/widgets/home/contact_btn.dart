import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';

class ContactBtn extends StatelessWidget {
  String iconPath;
  bool isWhatsApp;
  bool isPhoneCall;
  bool isVisitProfile;
  ContactBtn({required this.iconPath, required this.isPhoneCall, required this.isVisitProfile, required this.isWhatsApp});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(isWhatsApp){}
      },
      child: Container(
        height: 65,
        width: 65,
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(10)),
        child: Image.asset(iconPath),
      ),
    );
  }
}
