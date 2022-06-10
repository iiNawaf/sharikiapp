import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';

class PosterStatus extends StatelessWidget {
  const PosterStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      padding: EdgeInsets.only(right: 10, left: 10),
      decoration: BoxDecoration(
          color: dangerColor, borderRadius: BorderRadius.circular(25)),
      child: Center(
          child: Text(
        "مغلق",
        style: TextStyle(fontSize: 11, color: whiteColor),
      )),
    );
  }
}
