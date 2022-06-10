import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height: 150.0),
      items: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            decoration: BoxDecoration(
                color: primaryColor, borderRadius: BorderRadius.circular(15)),
          ),
        )
      ],
    );
  }
}
