import 'package:flutter/material.dart';
import 'package:sharikiapp/screens/sign_up/sign_up.dart';
import 'package:sharikiapp/styles.dart';
import 'package:sharikiapp/widgets/appbar.dart';
import 'package:sharikiapp/widgets/shared_widgets/submit_button.dart';
import 'package:sharikiapp/widgets/sign_up/account_type.dart';

enum AccTypes { undefined, individual, project }

class ChooseAccountTypeScreen extends StatefulWidget {
  @override
  State<ChooseAccountTypeScreen> createState() =>
      _ChooseAccountTypeScreenState();
}

class _ChooseAccountTypeScreenState extends State<ChooseAccountTypeScreen> {
  AccTypes _accTypes = AccTypes.undefined;
  String description = "";

  @override
  void dispose() {
    description = "";
    _accTypes = AccTypes.undefined;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SharedAppBar(title: ""),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _pageTitle(),
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AccountType(
                    imgPath: "./assets/icons/individual.png",
                    title: "فرد",
                    borderColor: _accTypes == AccTypes.individual
                        ? primaryColor
                        : whiteColor,
                    chooseAccount: () {
                      setState(() {
                        _accTypes = AccTypes.individual;
                        description =
                            "إنشاء حساب الفرد يسمح لك بالبحث عن فرص في احدى المشاريع الناشئة التي تبحث عن شريك.";
                      });
                    }),
                SizedBox(
                  width: 10,
                ),
                AccountType(
                    imgPath: './assets/icons/start-up.png',
                    title: "مشروع",
                    borderColor: _accTypes == AccTypes.project
                        ? primaryColor
                        : whiteColor,
                    chooseAccount: () {
                      setState(() {
                        _accTypes = AccTypes.project;
                        description =
                            "إنشاء حساب مشروع يسمح لك بالبحث عن شركاء مناسبين لبيئة مشروعك وحسب متطلبات مشروعك.";
                      });
                    }),
              ],
            ),
            SizedBox(height: 15),
            Text(
              description,
              style: TextStyle(fontSize: 15, color: textColor),
            ),
            SizedBox(height: 80),
            _accTypes != AccTypes.undefined
                ? Column(
                    children: [
                      SubmitButton(
                        submit: () {
                          if (_accTypes == AccTypes.individual) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SignUpScreen(accType: _accTypes)));
                          } else if (_accTypes == AccTypes.project) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SignUpScreen(accType: _accTypes)));
                          }
                        },
                        title: "التالي",
                      ),
                      _goBackToLogin(context),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

Widget _pageTitle() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "تسجيل حساب جديد",
        style: TextStyle(
            fontSize: 26, fontWeight: FontWeight.bold, color: primaryColor),
      ),
      Text(
        "اختر نوع الحساب",
        style: TextStyle(
            fontSize: 18, color: textColor, fontWeight: FontWeight.bold),
      ),
    ],
  );
}

Widget _goBackToLogin(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pop(context),
    child: Text(
      "عندك حساب؟",
      style: TextStyle(
          color: primaryColor, fontWeight: FontWeight.bold, fontSize: 16),
    ),
  );
}
