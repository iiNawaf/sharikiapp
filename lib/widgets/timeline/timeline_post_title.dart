import 'package:flutter/material.dart';

class TimelinePostTitle extends StatelessWidget {
  const TimelinePostTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Title",
      style: Theme.of(context).textTheme.titleSmall,
    );
  }
}
