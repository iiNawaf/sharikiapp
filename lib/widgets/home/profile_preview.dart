import 'package:flutter/material.dart';
import 'package:sharikiapp/models/user.dart';
import 'package:sharikiapp/screens/profile/user_profile.dart';
import 'package:sharikiapp/services/functions/navigations.dart';
import 'package:sharikiapp/styles/constant_styles.dart';

class ProfilePreview extends StatelessWidget {
  User user;
  ProfilePreview({required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () => navigateTo(context, UserProfile(user: user)),
        child: Container(
            height: 100,
            width: 100,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: whiteColor),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: bgColor,
                  backgroundImage:
                      NetworkImage(user.profileImage),
                ),
                Text(
                  "${user.firstName} ${user.lastName}",
                  style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('./assets/icons/location.png'),
                    Text(
                      "${user.city}",
                      style: TextStyle(
                        color: subTextColor,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 10),
                Text(
                  user.bio == ""
                      ? "(لايوجد وصف)"
                      : "${user.bio}",
                  style: TextStyle(
                      color: subTextColor,
                      fontSize: 13,
                      overflow: TextOverflow.ellipsis),
                  textAlign: TextAlign.center,
                ),
                Text(
                  user.accountType == "individual" 
                  ? "فرد"
                  : "مشروع",
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            )),
      ),
    );
  }
}
