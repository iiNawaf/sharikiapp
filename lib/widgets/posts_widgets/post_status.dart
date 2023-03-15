import 'package:flutter/material.dart';
import 'package:sharikiapp/utilities/styles/constant_styles.dart';

class PostStatus extends StatelessWidget {
  String status;
  PostStatus({required this.status});
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 10,
      // width: 30,
      padding: EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 10),
      decoration: BoxDecoration(
          color: status == "active" ? primaryColor : dangerColor, borderRadius: BorderRadius.circular(25)),
      child: Center(
          child: Text(
        status == "active" ? "متاح" : "مغلق",
        style: TextStyle(color: whiteColor, fontSize: 11),
      )),
    );
  }
}
