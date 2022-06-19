import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharikiapp/providers/auth_provider.dart';
import 'package:sharikiapp/screens/sign_up/choose_account_type.dart';
import 'package:sharikiapp/styles.dart';
import 'package:sharikiapp/widgets/loading/button_loading.dart';
import 'package:sharikiapp/widgets/shared_widgets/input_text_field.dart';
import 'package:sharikiapp/widgets/shared_widgets/submit_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('./assets/images/shariki_logo.png'),
              ],
            ),
            SizedBox(height: 100),
            Text(
              "تسجيل الدخول",
              style: TextStyle(
                  fontSize: 26, fontWeight: FontWeight.bold, color: primaryColor),
            ),
            SizedBox(height: 30),
            InputTextField(title: "البريد الالكتروني", isObsecure: false, controller: _emailController, maxLines: 1),
            SizedBox(height: 25),
            InputTextField(title: "كلمة المرور", isObsecure: true, controller: _passwordController, maxLines: 1),
            SizedBox(height: 5),
            Text(
              "نسيت كلمة المرور",
              style: TextStyle(
                  fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 35),
            isLoading ? ButtonLoading() 
            : SubmitButton(
              submit: () async{
                setState(() {
                  isLoading = true;
                });
                final result = await auth.login(
                  _emailController.text,
                  _passwordController.text
                );
                if(result != ""){
                  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result)),
                );
                }
                setState(() {
                  isLoading = false;
                });
                
              },
              title: "تسجيل الدخول"
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("ماعندك حساب؟ ", style: TextStyle(fontSize: 16, color: textColor, fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseAccountTypeScreen())),
                  child: Text("سجل الآن", style: TextStyle(fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold))),
              ],
            ),
            TextButton(
              onPressed: () async => auth.isLoggedInUser(),
              child: Text("Check Info")
              )
          ],
        ),
      ),
    ));
  }
}
