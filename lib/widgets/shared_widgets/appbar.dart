import 'package:flutter/material.dart';
import 'package:sharikiapp/screens/home/home.dart';
import 'package:sharikiapp/styles.dart';

class HomeAppBar extends StatelessWidget {
  String title;
  HomeAppBar({required this.title});
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      snap: true,
      floating: true,
      backgroundColor: bgColor,
      expandedHeight: 60,
      title: Text(title, style: TextStyle(color: primaryColor, fontSize: 18)),
      leading: GestureDetector(
        onTap: () => HomeScreen.scaffoldKey.currentState!.openDrawer(),
        child: Image.asset('./assets/icons/menu.png'),
      ),
    );
  }
}

class SharedAppBar extends StatelessWidget {
  String title;
  SharedAppBar({required this.title});
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromRGBO(0, 0, 0, 0),
      elevation: 0,
      iconTheme: IconThemeData(color: textColor),
      centerTitle: true,
      title: Text(title, style: TextStyle(color: primaryColor, fontSize: 18)),
    );
  }
}
