import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';

class PosterExperience extends StatelessWidget {
  const PosterExperience({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("محمد صلاح", style: TextStyle(fontWeight: FontWeight.bold, color: subTextColor),),
        Text("محمد صلاح", style: TextStyle(fontWeight: FontWeight.bold, color: subTextColor),),
        Text("محمد صلاح", style: TextStyle(fontWeight: FontWeight.bold, color: subTextColor),),
      ],
    );
  }
}