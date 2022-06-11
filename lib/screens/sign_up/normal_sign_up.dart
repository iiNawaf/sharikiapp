import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';
import 'package:sharikiapp/widgets/appbar.dart';
import 'package:sharikiapp/widgets/shared_widgets/input_text_field.dart';
import 'package:sharikiapp/widgets/shared_widgets/submit_button.dart';

class IndividualSignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SharedAppBar(title: "", isAppManager: false),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _pageTitle(),
              SizedBox(height: 100),
              Row(
                children: [
                  Expanded(
                    child:
                        InputTextField(title: "الاسم الاول", isObsecure: false),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: InputTextField(
                        title: "الاسم الاخير", isObsecure: false),
                  ),
                ],
              ),
              SizedBox(height: 20),
              InputTextField(title: "البريد الالكتروني", isObsecure: false),
              SizedBox(height: 20),
              InputTextField(
                  title: "رقم الجوال (يبدأ بـ05)", isObsecure: false),
              SizedBox(height: 20),
              InputTextField(title: "كلمة المرور", isObsecure: true),
              SizedBox(height: 30),
              Row(
                children: [
                  Text(
                    "بضغطك على تسجيل فأنت توافق على ",
                    style: TextStyle(color: textColor),
                  ),
                  Text(
                    "الشروط والأحكام",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: primaryColor),
                  )
                ],
              ),
              SubmitButton(title: "تسجيل", submit: () {})
            ],
          ),
        ),
      ),
    );
  }
}

Widget _pageTitle() {
  return Column(
    children: [
      Row(
        children: [
          Text(
            "تسجيل حساب جديد",
            style: TextStyle(
                fontSize: 26, fontWeight: FontWeight.bold, color: primaryColor),
          ),
        ],
      ),
      Row(
        children: [
          Text(
            "فرد",
            style: TextStyle(
                fontSize: 18, color: textColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ],
  );
}
