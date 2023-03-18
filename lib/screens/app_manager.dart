import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharikiapp/providers/auth_provider.dart';
import 'package:sharikiapp/screens/home/home.dart';
import 'package:sharikiapp/screens/profile/my_profile.dart';
import 'package:sharikiapp/screens/timeline/timeline.dart';
import 'package:sharikiapp/styles/constant_styles.dart';

class AppManager extends StatefulWidget {
  static int currentIndex = 0;
  @override
  State<AppManager> createState() => _AppManagerState();
}

class _AppManagerState extends State<AppManager> {
  List<Widget> _pages = [
    HomeScreen(), 
    TimelineScreen(), 
    MyProfileScreen()
  ];

  void _switchIndex(int index) {
    setState(() {
      AppManager.currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(60),
      //   child: SharedAppBar(
      //     isAppManager: true,
      //     title: AppManager.currentIndex == 0 
      //     ? "الرئيسية" 
      //     : AppManager.currentIndex == 1 && auth.loggedInUser!.accountType == "individual" 
      //     ? "عرض ملفك" 
      //     : AppManager.currentIndex == 1 && auth.loggedInUser!.accountType == "project"
      //     ? "طلب البحث عن شريك" 
      //     : "الملف الشخصي"
      //   ),
      // ),
      body: _pages.elementAt(AppManager.currentIndex),
      bottomNavigationBar: BottomNavigationBar(
              backgroundColor: primaryColor,
              selectedItemColor: whiteColor,
              elevation: 0,
              onTap: _switchIndex,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              currentIndex: AppManager.currentIndex,
              items: <BottomNavigationBarItem>[
                _bottomNavItem("./assets/icons/home.png", "●"),
                _bottomNavItem("./assets/icons/list.png", "●"),
                _bottomNavItem("./assets/icons/user.png", "●")
              ]
            )
    );
  }
}

BottomNavigationBarItem _bottomNavItem(String imgPath, String label) {
  return BottomNavigationBarItem(
    icon: Image.asset(imgPath, height: 25,),
    label: label,
    tooltip: ""
  );
}
