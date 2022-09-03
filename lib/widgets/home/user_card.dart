import 'package:flutter/material.dart';
import 'package:sharikiapp/models/user.dart';
import 'package:sharikiapp/screens/profile/user_profile.dart';
import 'package:sharikiapp/styles.dart';

class UserCard extends StatelessWidget {
  User user;
  UserCard({required this.user});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UserProfile(user: user)));
        },
        child: Container(
            width: 150.0,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: Image.network(user.profileImage),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8, top: 2.5),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 20,
                        color: textColor,
                      ),
                      Text(
                        "${user.firstName} ${user.lastName}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 1.5, fontSize: 13, color: textColor),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8, top: 2.5),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        size: 20,
                        color: textColor,
                      ),
                      Text(
                        "${user.city}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 1.5, fontSize: 13, color: textColor),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
