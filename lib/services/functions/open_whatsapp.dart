import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

void openWhatsApp(String number) async{
  var whatsAppAndroidLink = "whatsapp://send?phone=" + number + "&text=hello";
    var whatsAppIOSLink = "https://wa.me/$number?text=${Uri.parse("hello")}";
    if (Platform.isIOS) {
      print("asdg"); // for iOS phone only
      if (await canLaunch(whatsAppIOSLink)) {
        await launch(whatsAppIOSLink, forceSafariVC: false);
      } else {
        // showAppSnackbar(context, "failed", "حصل خطأ");
      }
    } else {
      // android , web
      if (await canLaunch(whatsAppAndroidLink)) {
        await launch(whatsAppAndroidLink);
      } else {
        // showAppSnackbar(context, "failed", "حصل خطأ");
      }
    }
}
