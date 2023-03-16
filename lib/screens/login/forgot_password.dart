import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharikiapp/models/validation.dart';
import 'package:sharikiapp/providers/auth_provider.dart';
import 'package:sharikiapp/services/functions/navigations.dart';
import 'package:sharikiapp/styles/constant_styles.dart';
import 'package:sharikiapp/widgets/shared_widgets/appbar.dart';
import 'package:sharikiapp/widgets/loading/button_loading.dart';
import 'package:sharikiapp/widgets/shared_widgets/input_text_field.dart';
import 'package:sharikiapp/widgets/shared_widgets/shared_alert_dialog.dart';
import 'package:sharikiapp/widgets/shared_widgets/submit_button.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: SharedAppBar(title: ""),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "نسيت كلمة المرور",
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  ),
                  SizedBox(height: 30),
                  InputTextField(
                      title: "البريد الالكتروني",
                      isObsecure: false,
                      inputType: TextInputType.emailAddress,
                      controller: _emailController,
                      maxLength: 500,
                      maxLines: 1),
                  SizedBox(height: 25),
                  isLoading
                      ? ButtonLoading()
                      : SubmitButton(
                          submit: () async {
                            setState(() {
                              isLoading = true;
                            });
                            if (_emailController.text.isEmpty) {
                              Validation.bottomMsg(context, "الحقل فارغ");
                              setState(() {
                                isLoading = false;
                              });
                              return;
                            }
                            final result = await auth
                                .forgotPassword(_emailController.text);
                            if (result == "") {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return SharedAlertDialog(
                                      title: 'تم الارسال',
                                      content: 'تم ارسال رسالة الى بريدك الالكتروني تتضمن استعادة كلمة المرور.',
                                      btnTitle: 'حسنا',
                                      btnTitle2: "",
                                      click: () => navigateToFirst(context),
                                      click2: () {},
                                    );
                                  });
                              setState(() {
                                _emailController.clear();
                              });
                            } else {
                              Validation.bottomMsg(context, result);
                            }

                            setState(() {
                              isLoading = false;
                            });
                          },
                          title: "ارسال"),
                ],
              ),
            ),
          ),
        ));
  }
}
