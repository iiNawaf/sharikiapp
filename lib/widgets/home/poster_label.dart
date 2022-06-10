import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';


class PosterLabel extends StatelessWidget {
  const PosterLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("محمد صلاح", style: TextStyle(fontWeight: FontWeight.bold, color: subTextColor),);
  }
}