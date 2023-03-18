import 'package:flutter/material.dart';
import 'package:sharikiapp/styles/constant_styles.dart';
import 'package:sharikiapp/widgets/shared_widgets/appbar.dart';
import 'package:sharikiapp/widgets/shared_widgets/contact_btn.dart';
import 'package:sharikiapp/widgets/timeline/timeline_post_content.dart';
import 'package:sharikiapp/widgets/timeline/timeline_post_image.dart';
import 'package:sharikiapp/widgets/timeline/timeline_post_time.dart';
import 'package:sharikiapp/widgets/timeline/timeline_post_title.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SharedAppBar(
          title: "المنشورات", 
          leading: IconButton(
            onPressed: (){},
            icon: Icon(Icons.add, color: primaryColor),
          )
          ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                containerBoxShadow
              ]
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                  children: [
                    TimelinePostImage(),
                    SizedBox(width: 10),
                    TimelinePostTitle(),
                  ],
                ),
                TimelinePostTime()
                  ],
                ),
                TimelinePostContent(),
                // ContactBtn(
                //   iconPath: './assets/icons/whatsapp.png', 
                //   isPhoneCall: false, 
                //   isVisitProfile: false, 
                //   isWhatsApp: true, 
                //   color: bgColor, 
                //   phoneNumber: "0594789491"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
