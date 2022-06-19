import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharikiapp/providers/auth_provider.dart';
import 'package:sharikiapp/styles.dart';
import 'package:sharikiapp/widgets/profile/change_profile_image_btn.dart';
import 'package:sharikiapp/widgets/profile/profile_majors.dart';
import 'package:sharikiapp/widgets/profile/profile_image.dart';
import 'package:sharikiapp/widgets/shared_widgets/input_dropdown.dart';
import 'package:sharikiapp/widgets/shared_widgets/input_text_field.dart';
import 'package:sharikiapp/widgets/shared_widgets/submit_button.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  void didChangeDependencies() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider != null) {
      _firstNameController.text = authProvider.loggedInUser!.firstName;
      _lastNameController.text = authProvider.loggedInUser!.lastName;
      _descriptionController.text = authProvider.loggedInUser!.bio;
      _phoneController.text = "0" + authProvider.loggedInUser!.phoneNumber.toString();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return auth.loggedInUser != null
        ? SingleChildScrollView(
            child: Column(
              children: [
                ProfileImage(imgPath: auth.loggedInUser!.profileImage),
                SizedBox(height: 10),
                ChangeProfileImageBtn(),
                SizedBox(height: 20),
                auth.loggedInUser!.accountType == "individual" 
                ? Row(
                  children: [
                    Expanded(
                        child: InputTextField(
                            title: "الاسم الاول",
                            isObsecure: false,
                            controller: _firstNameController,
                            maxLines: 1)),
                    SizedBox(width: 10),
                    Expanded(
                        child: InputTextField(
                            title: "الاسم الاخير",
                            isObsecure: false,
                            controller: _lastNameController,
                            maxLines: 1)),
                  ],
                ) : InputTextField(
                            title: "اسم المشروع",
                            isObsecure: false,
                            controller: _firstNameController,
                            maxLines: 1),
                SizedBox(height: 15),
                InputTextField(
                    title: "الوصف",
                    isObsecure: false,
                    controller: _descriptionController,
                    maxLines: 3),
                SizedBox(height: 15),
                InputTextField(
                    title: "رقم الجوال (يبدأ بـ05)",
                    isObsecure: false,
                    controller: _phoneController,
                    maxLines: 1),
                SizedBox(height: 15),
                InputDropDown(title: "${auth.loggedInUser!.city == "" ? "اختر المدينة" : auth.loggedInUser!.city}"),
                SizedBox(height: 15),
                auth.loggedInUser!.accountType == "individual"
                    ? Row(
                      children: [
                        Text(
                            "الخبرات (3 كحد أقصى)",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                      ],
                    )
                    : Container(),
                auth.loggedInUser!.accountType == "individual"
                    ? ProfileMajors()
                    : InputDropDown(title: "اختر مجال المشروع"),
                SizedBox(height: 20),
                SubmitButton(title: "حفظ", submit: () {})
              ],
            ),
          )
        : Center(
            child: Text("Unauthorized Access."),
          );
  }
}
