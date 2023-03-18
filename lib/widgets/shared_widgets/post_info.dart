import 'package:flutter/material.dart';
import 'package:sharikiapp/styles/constant_styles.dart';
import 'package:sharikiapp/widgets/shared_widgets/contact_btn.dart';
import 'package:sharikiapp/widgets/posts_widgets/post_description.dart';
import 'package:sharikiapp/widgets/posts_widgets/post_image.dart';
import 'package:sharikiapp/widgets/posts_widgets/post_title.dart';

class PostInfo extends StatelessWidget {
  String title;
  String description;
  String city;
  String requiredJob;
  String phoneNumber;
  String image;
  String accountType;
  PostInfo({
    Key? key,
    required this.title,
    required this.description,
    required this.city,
    required this.requiredJob,
    required this.phoneNumber,
    required this.image,
    required this.accountType
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Column(
          children: [
            SizedBox(height: 15),
            PostImage(
              height: 130,
              width: 130,
              img: image,
            ),
            SizedBox(height: 20),
            Container(height: 1, color: bgColor),
            Padding(
              padding:
                  const EdgeInsets.only(right: 15, left: 15, top: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("الاسم",
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold)),
                  PostTitle(title: title)
                ],
              ),
            ),
            Container(height: 1, color: bgColor),
            Padding(
              padding:
                  const EdgeInsets.only(right: 15, left: 15, top: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("المدينة",
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold)),
                  PostTitle(title: city)
                ],
              ),
            ),
            Container(height: 1, color: bgColor),
            Padding(
              padding:
                  const EdgeInsets.only(right: 15, left: 15, top: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      accountType == "individual"
                          ? "المجال العملي"
                          : "المجال العملي المطلوب",
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold)),
                  PostTitle(title: requiredJob)
                ],
              ),
            ),
            Container(height: 1, color: bgColor),
            Padding(
              padding: EdgeInsets.only(right: 15, left: 15, top: 8, bottom: 8),
              child: PostDescription(
                  description: description, overflow: TextOverflow.visible),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ContactBtn(
                iconPath: './assets/icons/whatsapp.png',
                isWhatsApp: true,
                isPhoneCall: false,
                isVisitProfile: false,
                color: bgColor,
                phoneNumber: phoneNumber,
              ),
              SizedBox(width: 20),
              ContactBtn(
                iconPath: './assets/icons/external-link.png',
                isWhatsApp: false,
                isPhoneCall: false,
                isVisitProfile: true,
                color: bgColor,
                phoneNumber: phoneNumber,
              ),
              SizedBox(width: 20),
              ContactBtn(
                iconPath: './assets/icons/telephone.png',
                isWhatsApp: false,
                isPhoneCall: true,
                isVisitProfile: false,
                color: bgColor,
                phoneNumber: phoneNumber,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
