import 'package:flutter/material.dart';
import 'package:sharikiapp/widgets/profile/change_profile_image_btn.dart';
import 'package:sharikiapp/widgets/profile/profile_image.dart';
import 'package:sharikiapp/widgets/shared_widgets/input_dropdown.dart';
import 'package:sharikiapp/widgets/shared_widgets/input_text_field.dart';
import 'package:sharikiapp/widgets/shared_widgets/submit_button.dart';

class MyProfileScreen extends StatelessWidget {
  TextEditingController _projectNameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfileImage(),
          SizedBox(height: 10),
          ChangeProfileImageBtn(),
          SizedBox(height: 20),
          InputTextField(title: "Name", isObsecure: false, controller: _projectNameController, maxLines: 1),
          SizedBox(height: 15),
          InputTextField(title: "الوصف", isObsecure: false, controller: _descriptionController, maxLines: 3),
          SizedBox(height: 15),
          InputTextField(title: "رقم الجوال (يبدأ ب05)", isObsecure: false, controller: _phoneController, maxLines: 1),
          SizedBox(height: 15),
          InputDropDown(title: "اختر المدينة"),
          SizedBox(height: 15),
          InputDropDown(title: "اختر مجال المشروع"),
          SizedBox(height: 20),
          SubmitButton(title: "حفظ", submit: (){})
        ],
      ),
    );
  }
}