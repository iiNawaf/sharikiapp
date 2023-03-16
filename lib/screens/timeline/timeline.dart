import 'package:flutter/material.dart';
import 'package:sharikiapp/widgets/shared_widgets/appbar.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SharedAppBar(title: "المنشورات"),
      ),
      
    );
  }
}
