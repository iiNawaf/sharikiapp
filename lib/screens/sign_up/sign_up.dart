import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharikiapp/providers/auth_provider.dart';
import 'package:sharikiapp/screens/sign_up/choose_account_type.dart';
import 'package:sharikiapp/styles.dart';
import 'package:sharikiapp/widgets/appbar.dart';
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

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
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
              _pageTitle(widget.accType == AccTypes.individual ? "فرد" : widget.accType == AccTypes.project ? "مشروع" : ""),
              SizedBox(height: 100),
              widget.accType == AccTypes.individual 
              ? Row(
                children: [
                  Expanded(
                    child: InputTextField(
                        title: "الاسم الاول",
                        isObsecure: false,
                        controller: _firstNameController,
                        maxLines: 1),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: InputTextField(
                        title: "الاسم الاخير",
                        isObsecure: false,
                        controller: _lastNameController,
                        maxLines: 1),
                  ),
                ],
              ) : widget.accType == AccTypes.project 
              ? InputTextField(title: "اسم المشروع", isObsecure: false, controller: _firstNameController, maxLines: 1)
              : Container(),
              SizedBox(height: 20),
              InputTextField(
                  title: "البريد الالكتروني",
                  isObsecure: false,
                  controller: _emailController,
                  maxLines: 1),
              SizedBox(height: 20),
              InputTextField(
                  title: "رقم الجوال (يبدأ بـ05)",
                  isObsecure: false,
                  controller: _phoneController,
                  maxLines: 1),
              SizedBox(height: 20),
              InputTextField(
                  title: "كلمة المرور",
                  isObsecure: true,
                  controller: _passwordController,
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
              SubmitButton(title: "تسجيل", submit: () async {
                setState(() {
                  isLoading = true;
                });
                final result = await auth.signUp(
                  _firstNameController.text,
                  widget.accType == AccTypes.individual ? _lastNameController.text : "",
                  _emailController.text,
                  _phoneController.text,
                  _passwordController.text,
                  widget.accType == AccTypes.individual 
                  ? "individual" 
                  : widget.accType == AccTypes.project 
                  ? "project" 
                  : ""
                );
                setState(() {
                  isLoading = false;
                });
                if(result != ""){
                  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result)),
                );
                }else{
                  Navigator.popUntil(context, (route) => route.isFirst);
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
