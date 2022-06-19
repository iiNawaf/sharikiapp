import 'package:flutter/material.dart';
import 'package:sharikiapp/widgets/appbar.dart';

class MajorsListScreen extends StatelessWidget {
  const MajorsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SharedAppBar(title: "الخبرات", isAppManager: false),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                title: Text("Major1"),
              ),
            )
          ],
        ),
      ),
    );
  }
}