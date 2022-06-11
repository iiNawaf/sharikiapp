import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';
import 'package:sharikiapp/widgets/home/contact_btn.dart';
import 'package:sharikiapp/widgets/home/home_slider.dart';
import 'package:sharikiapp/widgets/home/poster_city.dart';
import 'package:sharikiapp/widgets/home/poster_description.dart';
import 'package:sharikiapp/widgets/home/poster_experience.dart';
import 'package:sharikiapp/widgets/home/poster_image.dart';
import 'package:sharikiapp/widgets/home/poster_label.dart';
import 'package:sharikiapp/widgets/home/poster_major.dart';
import 'package:sharikiapp/widgets/home/poster_status.dart';
import 'package:sharikiapp/widgets/home/poster_time.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            HomeSlider(),
            SizedBox(height: 10),
            Column(
                children: [
                  _pageTitle("أحدث الشركاء"),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => showModalBottomSheet(
                      context: context,
                      backgroundColor: whiteColor,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      builder: (context){
                        return Wrap(
                          children: [
                            Column(
                              children: [
                                SizedBox(height: 15),
                                PosterImage(height: 130, width: 130),
                                SizedBox(height: 20),
                                Container(height: 1, color: bgColor),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15, left: 15, top: 8, bottom: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("الاسم", style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
                                      PosterLabel()
                                    ],
                                  ),
                                ),
                                Container(height: 1, color: bgColor),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15, left: 15, top: 8, bottom: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("الخبرات", style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
                                      PosterExperience()
                                    ],
                                  ),
                                ),
                                Container(height: 1, color: bgColor),
                                Padding(
                                  padding: EdgeInsets.only(right: 15, left: 15, top: 8, bottom: 8),
                                  child: PosterDescription(overflow: TextOverflow.visible),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20, bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ContactBtn(iconPath: './assets/icons/whatsapp.png'),
                                  SizedBox(width: 20),
                                  ContactBtn(iconPath: './assets/icons/external-link.png'),
                                  SizedBox(width: 20),
                                  ContactBtn(iconPath: './assets/icons/telephone.png'),
                                ],
                              ),
                            ),

                          ],
                        );
                      }
                    ),
                    child: Container(
                      height: 190,
                      padding: EdgeInsets.only(right: 15, left: 15, top: 15),
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PosterImage(height: 60, width: 60),
                                  SizedBox(width: 5),
                                  Container(
                                    height: 55,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        PosterLabel(),
                                        PosterCity()
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              PosterStatus(),
                            ],
                          ),
                          SizedBox(height: 10),
                          PosterDescription(overflow: TextOverflow.ellipsis,),
                          SizedBox(height: 30),
                          Container(
                            height: 1,
                            color: bgColor,
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [PosterMajor(), PosterTime()],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      );
  }
}

Widget _pageTitle(String title) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(
            fontSize: 16, color: textColor, fontWeight: FontWeight.bold),
      ),
      Text(
        "المزيد",
        style: TextStyle(
            fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
      )
    ],
  );
}
