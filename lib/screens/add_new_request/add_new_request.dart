import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharikiapp/models/city.dart';
import 'package:sharikiapp/models/validation.dart';
import 'package:sharikiapp/providers/auth_provider.dart';
import 'package:sharikiapp/providers/post_provider.dart';
import 'package:sharikiapp/widgets/appbar.dart';
import 'package:sharikiapp/widgets/loading/button_loading.dart';
import 'package:sharikiapp/widgets/shared_widgets/input_dropdown.dart';
import 'package:sharikiapp/widgets/shared_widgets/input_text_field.dart';
import 'package:sharikiapp/widgets/shared_widgets/submit_button.dart';

class AddNewRequestScreen extends StatefulWidget {
  @override
  State<AddNewRequestScreen> createState() => _AddNewRequestScreenState();
}

class _AddNewRequestScreenState extends State<AddNewRequestScreen> {
  TextEditingController _requiredJobController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  City city = City();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final postProvider = Provider.of<PostProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SharedAppBar(
          title: auth.loggedInUser!.accountType == "individual"
              ? "عرض ملفك"
              : "طلب بحث عن شريك",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              auth.loggedInUser!.accountType == "individual"
                  ? InputTextField(
                      title: "مجالك العملي (مثال:مصمم)",
                      isObsecure: false,
                      inputType: TextInputType.text,
                      controller: _requiredJobController,
                      maxLength: 20,
                      maxLines: 1)
                  : InputTextField(
                      title: "المجال العملي المطلوب (مثال:مصمم)",
                      isObsecure: false,
                      inputType: TextInputType.text,
                      controller: _requiredJobController,
                      maxLength: 20,
                      maxLines: 1),
              SizedBox(height: 20),
              auth.loggedInUser!.accountType == "project"
                  ? InputDropDown(
                      list: ['', 'يوجد', 'لا يوجد'],
                      title: "الراتب",
                    )
                  : Container(),
              SizedBox(height: 20),
              InputTextField(
                  title: "الوصف",
                  isObsecure: false,
                  inputType: TextInputType.multiline,
                  controller: _descriptionController,
                  maxLength: 250,
                  maxLines: 3),
              SizedBox(height: 35),
              isLoading
                  ? ButtonLoading()
                  : SubmitButton(
                      title: "اضافة",
                      submit: () async {
                        setState(() {
                          isLoading = true;
                        });
                        if (Validation.isEmpty(_requiredJobController.text) ||
                            Validation.isEmpty(_descriptionController.text)) {
                          Validation.bottomMsg(context, "يوجد حقل فارغ");
                          setState(() {
                            isLoading = false;
                          });
                        } else if (!Validation.nameValidation(
                            _requiredJobController.text)) {
                          Validation.bottomMsg(
                              context,
                              auth.loggedInUser!.accountType == "individual"
                                  ? "الرجاء كتابة مجالك العملي بشكل صحيح"
                                  : "الرجاء كتابة المجال العملي المطلوب بشكل صحيح");
                        } else {
                          showDialog(
                              // The user CANNOT close this dialog  by pressing outsite it
                              barrierDismissible: false,
                              context: context,
                              builder: (_) {
                                return loadingDialog();
                              });
                          final result = await postProvider.addNewPost(
                              auth.loggedInUser!.id,
                              auth.loggedInUser!.phoneNumber,
                              auth.loggedInUser!.accountType == "individual"
                                  ? auth.loggedInUser!.firstName +
                                      " " +
                                      auth.loggedInUser!.lastName
                                  : auth.loggedInUser!.firstName,
                              auth.loggedInUser!.city,
                              _requiredJobController.text,
                              _descriptionController.text,
                              auth.loggedInUser!.accountType);
                          //clear inputs
                          setState(() {
                            _descriptionController.clear();
                            _requiredJobController.clear();
                            isLoading = false;
                          });
                          Navigator.pop(context);
                          _showSuccessDialog(context);
                        }
                      })
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _showSuccessDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('تم ارسال طلبك'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('تم ارسال طلبك بنجاح'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('حسنا'),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      );
    },
  );
}

Widget loadingDialog() {
  return Dialog(
    // The background color
    backgroundColor: Colors.white,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          // The loading indicator
          CircularProgressIndicator(),
          SizedBox(
            height: 15,
          ),
          // Some text
          Text('الرجاء الانتظار')
        ],
      ),
    ),
  );
}
