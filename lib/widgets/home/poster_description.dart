import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';


class PosterDescription extends StatelessWidget {
  const PosterDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum",
       style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: subTextColor),
       overflow: TextOverflow.ellipsis,);
  }
}