import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sharikiapp/models/city.dart';
import 'package:sharikiapp/models/validation.dart';
import 'package:sharikiapp/providers/auth_provider.dart';
import 'package:sharikiapp/widgets/appbar.dart';
import 'package:sharikiapp/widgets/loading/button_loading.dart';
import 'package:sharikiapp/widgets/profile/change_profile_image_btn.dart';
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
  TextEditingController _bioController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  bool isLoading = false;
  City city = City();

  @override
  void didChangeDependencies() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _firstNameController.text = authProvider.loggedInUser!.firstName;
    _lastNameController.text = authProvider.loggedInUser!.lastName;
    _bioController.text = authProvider.loggedInUser!.bio;
    _phoneController.text = authProvider.loggedInUser!.phoneNumber;
    InputDropDown.selectedCity = authProvider.loggedInUser!.city;
    super.didChangeDependencies();
  }

  File? imageFile;

  Future pickImage(AuthProvider auth) async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          isLoading = true;
          imageFile = File(pickedImage.path);
        });
        final result = await auth.upload(imageFile!);
        Validation.bottomMsg(context, result);
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("image error, try again");
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SharedAppBar(title: ""),
      ),
      body: auth.loggedInUser != null
          ? Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    imageFile != null
                        ? ProfileImage(image: FileImage(imageFile!))
                        : ProfileImage(
                            image:
                                NetworkImage(auth.loggedInUser!.profileImage)),
                    SizedBox(height: 10),
                    isLoading 
                    ? Container() 
                    : ChangeProfileImageBtn(pickImage: () => pickImage(auth)),
                    SizedBox(height: 20),
                    auth.loggedInUser!.accountType == "individual"
                        ? Row(
                            children: [
                              Expanded(
                                  child: InputTextField(
                                      title: "الاسم الاول",
                                      isObsecure: false,
                                      inputType: TextInputType.text,
                                      controller: _firstNameController,
                                      maxLength: 15,
                                      maxLines: 1)),
                              SizedBox(width: 10),
                              Expanded(
                                  child: InputTextField(
                                      title: "الاسم الاخير",
                                      isObsecure: false,
                                      inputType: TextInputType.text,
                                      controller: _lastNameController,
                                      maxLength: 15,
                                      maxLines: 1)),
                            ],
                          )
                        : InputTextField(
                            title: "اسم المشروع",
                            isObsecure: false,
                            inputType: TextInputType.text,
                            controller: _firstNameController,
                            maxLength: 20,
                            maxLines: 1),
                    SizedBox(height: 15),
                    InputTextField(
                        title: "الوصف",
                        isObsecure: false,
                        inputType: TextInputType.multiline,
                        controller: _bioController,
                        maxLength: 250,
                        maxLines: 3),
                    SizedBox(height: 15),
                    InputTextField(
                        title: "رقم الجوال (يبدأ بـ05)",
                        isObsecure: false,
                        inputType: TextInputType.number,
                        controller: _phoneController,
                        maxLength: 10,
                        maxLines: 1),
                    SizedBox(height: 15),
                    InputDropDown(
                      title:
                          "${auth.loggedInUser!.city == "" ? "اختر المدينة" : auth.loggedInUser!.city}",
                      list: city.cities.values.toList(),
                    ),
                    SizedBox(height: 20),
                    isLoading
                        ? ButtonLoading()
                        : SubmitButton(
                            title: "حفظ",
                            submit: () async {
                              setState(() {
                                isLoading = true;
                              });
                              if (Validation.isEmpty(
                                      _firstNameController.text) ||
                                  (auth.loggedInUser!.accountType ==
                                          "individual" &&
                                      Validation.isEmpty(
                                          _lastNameController.text)) ||
                                  Validation.isEmpty(_phoneController.text)) {
                                Validation.bottomMsg(
                                    context, "الرجاء عدم ترك أي حقل فارغ");
                                setState(() {
                                  isLoading = false;
                                });
                              } else if (!Validation.nameValidation(
                                      _firstNameController.text) ||
                                  (auth.loggedInUser!.accountType ==
                                          "individual" &&
                                      !Validation.nameValidation(
                                          _lastNameController.text))) {
                                Validation.bottomMsg(context,
                                    "الرجاء كتابة الاسم كامل باللغة الانجليزية");
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
                              } else {
                                final result = await auth.updateUserProfileInfo(
                                    _firstNameController.text,
                                    auth.loggedInUser!.accountType ==
                                            "individual"
                                        ? _lastNameController.text
                                        : "",
                                    _bioController.text,
                                    _phoneController.text,
                                    InputDropDown.selectedCity);
                                setState(() {
                                  isLoading = false;
                                });
                                Validation.bottomMsg(context, result);
                              }
                            })
                  ],
                ),
              ),
            )
          : Center(
              child: Text("Unauthorized Access."),
            ),
    );
  }
}
