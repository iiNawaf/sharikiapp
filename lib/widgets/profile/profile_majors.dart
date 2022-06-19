import 'package:flutter/material.dart';
import 'package:sharikiapp/screens/profile/majors_list.dart';
import 'package:sharikiapp/styles.dart';

class ProfileMajors extends StatelessWidget {
  const ProfileMajors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MajorsListScreen())),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                color: whiteColor, borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('./assets/icons/plus.png'),
                Text(
                  "إضافة",
                  style: TextStyle(fontSize: 12, color: subTextColor),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
