import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sharikiapp/models/city.dart';
import 'package:sharikiapp/models/major.dart';
import 'package:sharikiapp/providers/auth_provider.dart';
import 'package:sharikiapp/styles.dart';
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
  List<dynamic> currentUserMajors = [];
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _firstNameController.text = authProvider.loggedInUser!.firstName;
    _lastNameController.text = authProvider.loggedInUser!.lastName;
    _bioController.text = authProvider.loggedInUser!.bio;
    _phoneController.text = authProvider.loggedInUser!.phoneNumber;
    InputDropDown.selectedCity = authProvider.loggedInUser!.city;
    currentUserMajors = authProvider.loggedInUser!.majors;
    if (authProvider.loggedInUser!.accountType == "project") {
      InputDropDown.selectedMajor = authProvider.loggedInUser!.majors[0];
    }
    super.didChangeDependencies();
  }

  City city = City();
  Major major = Major();

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
                      )
                    : InputTextField(
                        title: "اسم المشروع",
                        isObsecure: false,
                        controller: _firstNameController,
                        maxLines: 1),
                SizedBox(height: 15),
                InputTextField(
                    title: "الوصف",
                    isObsecure: false,
                    controller: _bioController,
                    maxLines: 3),
                SizedBox(height: 15),
                InputTextField(
                    title: "رقم الجوال (يبدأ بـ05)",
                    isObsecure: false,
                    controller: _phoneController,
                    maxLines: 1),
                SizedBox(height: 15),
                InputDropDown(
                  title:
                      "${auth.loggedInUser!.city == "" ? "اختر المدينة" : auth.loggedInUser!.city}",
                  list: city.cities.values.toList(),
                  isCity: true,
                ),
                SizedBox(height: 15),
                auth.loggedInUser!.accountType == "individual"
                    ? _majorsLabel()
                    : Container(),
                auth.loggedInUser!.accountType == "individual"
                    ? Container(
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: MultiSelectDialogField(
                          items: major.userMajors.values
                              .map((e) => MultiSelectItem(e, e))
                              .toList(),
                          listType: MultiSelectListType.CHIP,
                          initialValue: currentUserMajors,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.transparent)),
                          onConfirm: (values) => currentUserMajors = values,
                        ),
                      )
                    : InputDropDown(
                        title:
                            "${currentUserMajors.isEmpty || currentUserMajors[0] == "" ? "اختر مجال المشروع" : currentUserMajors[0]}",
                        list: major.projectMajors.values.toList(),
                        isCity: false,
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
                          final result = await auth.updateUserProfileInfo(
                            _firstNameController.text,
                            auth.loggedInUser!.accountType == "individual"
                                ? _lastNameController.text
                                : "",
                            _bioController.text,
                            _phoneController.text,
                            InputDropDown.selectedCity,
                            auth.loggedInUser!.accountType == "individual" 
                            ? currentUserMajors
                            : [InputDropDown.selectedMajor],
                          );
                          setState(() {
                            isLoading = false;
                          });

                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(result)));
                        })
              ],
            ),
          )
        : Center(
            child: Text("Unauthorized Access."),
          );
  }

  Widget _majorsLabel() {
    return Row(
      children: [
        Text(
          "الخبرات (3 كحد أقصى)",
          textAlign: TextAlign.start,
          style: TextStyle(
              color: textColor, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ],
    );
  }
}
