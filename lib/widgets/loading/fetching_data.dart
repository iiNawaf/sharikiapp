import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';

class FetchingDataLoading extends StatelessWidget {
  const FetchingDataLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: primaryColor),
          Text("Fetching Data...")
        ],
      ),
    );
  }
}