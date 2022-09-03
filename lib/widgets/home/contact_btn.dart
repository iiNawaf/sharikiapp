import 'package:flutter/material.dart';
import 'package:sharikiapp/models/user.dart';
import 'package:sharikiapp/models/validation.dart';
import 'package:sharikiapp/screens/profile/user_profile.dart';
import 'package:sharikiapp/styles.dart';
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
        if (isWhatsApp) {
          final url = "whatsapp://send?phone=$phoneNumber&text=hello";
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            // Navigator.pop(context);
            Validation.bottomMsg(context, "الرجاء تحميل WhatsApp");
          }
        } else if (isPhoneCall) {
          await launch("tel://$phoneNumber");
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
