import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharikiapp/models/validation.dart';
import 'package:sharikiapp/providers/auth_provider.dart';
import 'package:sharikiapp/services/functions/navigations.dart';
import 'package:sharikiapp/styles/constant_styles.dart';
import 'package:sharikiapp/widgets/loading/button_loading.dart';
import 'package:sharikiapp/widgets/shared_widgets/shared_alert_dialog.dart';

class DeleteButton extends StatelessWidget {
  bool isLoading;
  DeleteButton({required this.isLoading});
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return GestureDetector(
      onTap: () => showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return StatefulBuilder(builder: (context, setState) {
              return isLoading
                  ? ButtonLoading()
                  : SharedAlertDialog(
                      title: "حذف الحساب",
                      content: Text("هل متأكد من حذف حسابك؟",
                      style: TextStyle(color: textColor, fontSize: 14),
                      ),
                      btnTitle: "نعم",
                      btnTitle2: "لا",
                      click: () async {
                        setState(() {
                          isLoading = true;
                        });
                        final result = await auth.disableAccount();
                        if (result != "") {
                          Validation.bottomMsg(context, result);
                        }
                        setState(() {
                          isLoading = false;
                        });
                        navigateToFirst(context);
                        Future.delayed(Duration(milliseconds: 500), () {
                          auth.logout();
                        });
                      },
                      click2: () => navigateBack(context),
                    );
            });
          }),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: dangerColor),
        ),
        child: Center(
          child: Text(
            "حذف الحساب",
            style: TextStyle(
                color: dangerColor, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
