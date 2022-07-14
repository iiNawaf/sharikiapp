import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharikiapp/models/city.dart';
import 'package:sharikiapp/models/major.dart';
import 'package:sharikiapp/providers/auth_provider.dart';
import 'package:sharikiapp/providers/post_provider.dart';
import 'package:sharikiapp/widgets/shared_widgets/input_dropdown.dart';
import 'package:sharikiapp/widgets/shared_widgets/input_text_field.dart';
import 'package:sharikiapp/widgets/shared_widgets/submit_button.dart';

class AddNewRequestScreen extends StatefulWidget {
  @override
  State<AddNewRequestScreen> createState() => _AddNewRequestScreenState();
}

class _AddNewRequestScreenState extends State<AddNewRequestScreen> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String _currentCity = "";
  Major major = Major();
  City city = City();

  @override
  void didChangeDependencies() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _firstNameController.text = authProvider.loggedInUser!.firstName;
    _lastNameController.text = authProvider.loggedInUser!.lastName;
    _phoneNumberController.text = authProvider.loggedInUser!.phoneNumber;
    _currentCity = authProvider.loggedInUser!.city;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final postProvider = Provider.of<PostProvider>(context);
    return SingleChildScrollView(
      child: Column(
          children: [
            SizedBox(height: 50),
            auth.loggedInUser!.accountType == "individual" 
            ? Row(
              children: [
                Expanded(child: InputTextField(title: "الاسم الاول", isObsecure: false, controller: _firstNameController, maxLines: 1)),
                SizedBox(width: 10),
                Expanded(child: InputTextField(title: "الاسم الاخير", isObsecure: false, controller: _lastNameController, maxLines: 1)),
              ],
            ) : InputTextField(title: "اسم المشروع", isObsecure: false, controller: _firstNameController, maxLines: 1),
            
            SizedBox(height: 20),

            InputTextField(title: "رقم الجوال", isObsecure: false, controller: _phoneNumberController, maxLines: 1),

            SizedBox(height: 20),

            InputDropDown(title: _currentCity == "" ? "اختر المدينة" : _currentCity, isCity: true, list: city.cities.values.toList(),),

            SizedBox(height: 20),

            auth.loggedInUser!.accountType == "individual" 
            ? InputDropDown(title: "اختر مجالك", isCity: false, list: major.userMajors.values.toList())
            : InputDropDown(title: "اختر المجال المطلوب", isCity: false, list: major.userMajors.values.toList()),

            SizedBox(height: 20),
            
            InputTextField(title: "الوصف", isObsecure: false, controller: _descriptionController, maxLines: 3),

            SizedBox(height: 35),

            SubmitButton(title: "اضافة", submit: () async{
              await postProvider.addNewPost(
                auth.loggedInUser!.id,
                _firstNameController.text + " " + _lastNameController.text, 
                
                InputDropDown.selectedMajor,
                InputDropDown.selectedCity, 
                _descriptionController.text,
                );
            })
          ],
        ),
    );
  }
}