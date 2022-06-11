import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 130,
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(100)),
      child: Center(
        child: Image.asset('./assets/icons/user.png'),
      ),
    );
  }
}
