import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharikiapp/models/city.dart';
import 'package:sharikiapp/models/validation.dart';
import 'package:sharikiapp/providers/auth_provider.dart';
import 'package:sharikiapp/screens/sign_up/choose_account_type.dart';
import 'package:sharikiapp/styles.dart';
import 'package:sharikiapp/widgets/appbar.dart';
import 'package:sharikiapp/widgets/loading/button_loading.dart';
import 'package:sharikiapp/widgets/shared_widgets/input_dropdown.dart';
import 'package:sharikiapp/widgets/shared_widgets/input_text_field.dart';
import 'package:sharikiapp/widgets/shared_widgets/submit_button.dart';

class SignUpScreen extends StatefulWidget {
  AccTypes accType;
  SignUpScreen({required this.accType});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  City city = City();

  @override
  Widget build(BuildContext context) {
    InputDropDown.selectedCity = "";
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SharedAppBar(title: ""),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _pageTitle(widget.accType == AccTypes.individual
                  ? "فرد"
                  : widget.accType == AccTypes.project
                      ? "مشروع"
                      : ""),
              SizedBox(height: 50),
              widget.accType == AccTypes.individual
                  ? Row(
                      children: [
                        Expanded(
                          child: InputTextField(
                              title: "الاسم الاول",
                              isObsecure: false,
                              inputType: TextInputType.text,
                              controller: _firstNameController,
                              maxLength: 15,
                              maxLines: 1),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: InputTextField(
                              title: "الاسم الاخير",
                              isObsecure: false,
                              inputType: TextInputType.text,
                              controller: _lastNameController,
                              maxLength: 15,
                              maxLines: 1),
                        ),
                      ],
                    )
                  : widget.accType == AccTypes.project
                      ? InputTextField(
                          title: "اسم المشروع",
                          isObsecure: false,
                          inputType: TextInputType.text,
                          controller: _firstNameController,
                          maxLength: 20,
                          maxLines: 1)
                      : Container(),
              SizedBox(height: 20),
              InputTextField(
                  title: "البريد الالكتروني",
                  isObsecure: false,
                  inputType: TextInputType.emailAddress,
                  controller: _emailController,
                  maxLength: 100,
                  maxLines: 1),
              SizedBox(height: 20),
              InputTextField(
                  title: "رقم الجوال (يبدأ بـ05)",
                  isObsecure: false,
                  inputType: TextInputType.number,
                  controller: _phoneController,
                  maxLength: 10,
                  maxLines: 1),
              SizedBox(height: 20),
              InputDropDown(
                  title: "المدينة", list: city.cities.values.toList()),
              SizedBox(height: 20),
              InputTextField(
                  title: "كلمة المرور",
                  isObsecure: true,
                  inputType: TextInputType.text,
                  controller: _passwordController,
                  maxLength: 100,
                  maxLines: 1),
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
              isLoading
                  ? ButtonLoading()
                  : SubmitButton(
                      title: "تسجيل",
                      submit: () async {
                        setState(() {
                          isLoading = true;
                        });
                        if (Validation.isEmpty(_firstNameController.text) ||
                            (widget.accType == AccTypes.individual &&
                                Validation.isEmpty(_lastNameController.text)) ||
                            Validation.isEmpty(_emailController.text) ||
                            Validation.isEmpty(_phoneController.text) ||
                            Validation.isEmpty(_passwordController.text)) {
                          Validation.bottomMsg(
                              context, "الرجاء عدم ترك أي حقل فارغ");
                          setState(() {
                            isLoading = false;
                          });
                        } else if (!Validation.nameValidation(
                                _firstNameController.text) ||
                            (widget.accType == AccTypes.individual &&
                                !Validation.nameValidation(
                                    _lastNameController.text))) {
                          Validation.bottomMsg(context,
                              "الرجاء كتابة الاسم كامل باللغة الانجليزية");
                          setState(() {
                            isLoading = false;
                          });
                        } else if (!Validation.emailValidation(
                            _emailController.text)) {
                          Validation.bottomMsg(context,
                              "الرجاء كتابة البريد الالكتروني بشكل صحيح");
                          setState(() {
                            isLoading = false;
                          });
                        } else if (!Validation.phoneNumberValidation(
                            _phoneController.text)) {
                          Validation.bottomMsg(context,
                              "رقم الجوال يجب أن يبدأ ب05 وأن يتكون من 10 أرقام");
                          setState(() {
                            isLoading = false;
                          });
                        } else if (InputDropDown.selectedCity == "") {
                          Validation.bottomMsg(
                              context, "الرجاء اختيار المدينة");
                          setState(() {
                            isLoading = false;
                          });
                        } else {
                          final result = await auth.signUp(
                              _firstNameController.text,
                              widget.accType == AccTypes.individual
                                  ? _lastNameController.text
                                  : "",
                              _emailController.text,
                              _phoneController.text,
                              _passwordController.text,
                              widget.accType == AccTypes.individual
                                  ? "individual"
                                  : widget.accType == AccTypes.project
                                      ? "project"
                                      : "",
                              InputDropDown.selectedCity);
                          setState(() {
                            isLoading = false;
                          });
                          if (result != "") {
                            Validation.bottomMsg(context, result);
                          } else {
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                          }
                        }
                      })
            ],
          ),
        ),
      ),
    );
  }
}

Widget _pageTitle(String type) {
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
            type,
            style: TextStyle(
                fontSize: 18, color: textColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ],
  );
}
