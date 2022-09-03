import 'package:flutter/material.dart';
import 'package:sharikiapp/models/post.dart';
import 'package:sharikiapp/screens/home/home.dart';
import 'package:sharikiapp/styles.dart';

class HomeOption extends StatelessWidget {
  Post post;
  HomeOption({required this.post});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: whiteColor,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            builder: (context) => postInfo(
              post.title,
              post.description,
              post.city,
              post.requiredJob,
              post.publisherPhoneNumber
            ),
          );
        },
        child: Container(
        width: 100.0,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),

      ),
      ),
    );
  }
}
