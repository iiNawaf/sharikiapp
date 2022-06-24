import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharikiapp/widgets/shared_widgets/input_dropdown.dart';
import 'package:sharikiapp/widgets/shared_widgets/input_text_field.dart';
import 'package:sharikiapp/widgets/shared_widgets/submit_button.dart';

class AddNewRequestScreen extends StatelessWidget {
  TextEditingController _requestedExperienceYearsController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: [
            SizedBox(height: 50),
            // InputDropDown(title: "اختر المجال المطلوب",),
            SizedBox(height: 20),
            InputTextField(title: "سنوات الخبرة المطلوبة", isObsecure: false, controller: _requestedExperienceYearsController, maxLines: 1),
            SizedBox(height: 20),
            InputTextField(title: "الوصف", isObsecure: false, controller: _descriptionController, maxLines: 3),
            SizedBox(height: 35),
            SubmitButton(title: "اضافة", submit: (){})
          ],
        ),
    );
  }
}