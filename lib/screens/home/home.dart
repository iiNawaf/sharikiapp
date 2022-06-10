import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';
import 'package:sharikiapp/widgets/home/home_slider.dart';
import 'package:sharikiapp/widgets/home/poster_city.dart';
import 'package:sharikiapp/widgets/home/poster_description.dart';
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
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  _pageTitle("أحدث الشركاء"),
                  SizedBox(height: 10),
                  Container(
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
                                PosterImage(),
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
                        PosterDescription(),
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
                ],
              ),
            )
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
