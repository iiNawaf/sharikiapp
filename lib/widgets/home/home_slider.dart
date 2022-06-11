import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';

class HomeSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 150,
        viewportFraction: 1.0,
      ),
      items: [
        Container(
            decoration: BoxDecoration(
                color: primaryColor, borderRadius: BorderRadius.circular(15)),
          ),
      ],
    );
  }
}
