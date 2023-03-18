import 'package:flutter/material.dart';

class TimelinePostTime extends StatelessWidget {
  const TimelinePostTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "قبل ٤ ساعات",
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}
