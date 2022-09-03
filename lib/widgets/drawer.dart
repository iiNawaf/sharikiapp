import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharikiapp/providers/auth_provider.dart';
import 'package:sharikiapp/screens/add_new_request/add_new_request.dart';
import 'package:sharikiapp/screens/my_requests/my_requests.dart';
import 'package:sharikiapp/screens/profile/my_profile.dart';
import 'package:sharikiapp/styles.dart';

class HomeDrawer extends StatelessWidget {
  String title;
  String email;
  HomeDrawer({required this.title, required this.email});
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(title),
            accountEmail: Text(
              email,
              style: TextStyle(height: 1),
            ),
            currentAccountPictureSize: Size(70, 70),
            currentAccountPicture: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: bgColor,
                image: DecorationImage(
                  image: NetworkImage(auth.loggedInUser!.profileImage),
                  fit: BoxFit.contain,
                ),
                borderRadius: BorderRadius.all(Radius.circular(80.0)),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: const Text('الرئيسية'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: const Text('طلب جديد'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddNewRequestScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.library_books),
            title: const Text('طلباتي'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyRequests()));
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: const Text('الملف الشخصي'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfileScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: const Text('تسجيل الخروج'),
            onTap: () {
              auth.logout();
            },
          ),
        ],
      ),
    );
  }
}
