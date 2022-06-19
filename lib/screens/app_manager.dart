import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharikiapp/providers/auth_provider.dart';
import 'package:sharikiapp/screens/add_new_request/add_new_request.dart';
import 'package:sharikiapp/screens/home/home.dart';
import 'package:sharikiapp/screens/profile/my_profile.dart';
import 'package:sharikiapp/styles.dart';
import 'package:sharikiapp/widgets/appbar.dart';

class AppManager extends StatefulWidget {
  const AppManager({Key? key}) : super(key: key);

  @override
  State<AppManager> createState() => _AppManagerState();
}

class _AppManagerState extends State<AppManager> {
  int _currentIndex = 0;
  List<Widget> _pages = [
    HomeScreen(), 
    AddNewRequestScreen(), 
    MyProfileScreen()
  ];

  void _switchIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    if(auth.loggedInUser!.accountType == "individual"){
      _pages[1] = MyProfileScreen();
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SharedAppBar(
          isAppManager: true,
          title: _currentIndex == 0 ? "الرئيسية" 
          : _currentIndex == 1 && auth.loggedInUser!.accountType == "individual" ? "الملف الشخصي" : "طلب بحث عن شريك"  ,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: _pages.elementAt(_currentIndex),
      ),
      bottomNavigationBar: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15)
              )
            ),
            child: BottomNavigationBar(
              backgroundColor: primaryColor,
              selectedItemColor: whiteColor,
              elevation: 0,
              onTap: _switchIndex,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              currentIndex: _currentIndex,
              items: auth.loggedInUser!.accountType == "project" 
              ? <BottomNavigationBarItem>[
                _bottomNavItem("./assets/icons/home.png", "●"),
                _bottomNavItem("./assets/icons/add.png", "●"),
                _bottomNavItem("./assets/icons/user.png", "●")
              ] : <BottomNavigationBarItem>[
                _bottomNavItem("./assets/icons/home.png", "●"),
                _bottomNavItem("./assets/icons/user.png", "●")
              ],
            ),
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
