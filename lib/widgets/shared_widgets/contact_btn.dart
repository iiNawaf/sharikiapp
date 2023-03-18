import 'package:flutter/material.dart';
import 'package:sharikiapp/services/functions/open_whatsapp.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactBtn extends StatelessWidget {
  String iconPath;
  bool isWhatsApp;
  bool isPhoneCall;
  bool isVisitProfile;
  Color color;
  String phoneNumber;
  ContactBtn({
    required this.iconPath,
    required this.isPhoneCall,
    required this.isVisitProfile,
    required this.isWhatsApp,
    required this.color,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final numberWithCode = phoneNumber.replaceFirst("0", "00966");
        if (isWhatsApp) {
          openWhatsApp(numberWithCode);
        } else if (isPhoneCall) {
          print("asdf");
          await launch("tel://$numberWithCode");
        } else {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile(user: user)));
        }
      },
      child: Container(
        height: 65,
        width: 65,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: Image.asset(iconPath),
      ),
    );
  }
}
