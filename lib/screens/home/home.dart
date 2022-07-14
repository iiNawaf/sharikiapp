import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharikiapp/providers/auth_provider.dart';
import 'package:sharikiapp/providers/post_provider.dart';
import 'package:sharikiapp/screens/splash/splash.dart';
import 'package:sharikiapp/styles.dart';
import 'package:sharikiapp/widgets/home/contact_btn.dart';
import 'package:sharikiapp/widgets/home/home_slider.dart';
import 'package:sharikiapp/widgets/home/post_city.dart';
import 'package:sharikiapp/widgets/home/post_description.dart';
import 'package:sharikiapp/widgets/home/post_image.dart';
import 'package:sharikiapp/widgets/home/post_title.dart';
import 'package:sharikiapp/widgets/home/post_requested_major.dart';
import 'package:sharikiapp/widgets/home/post_status.dart';
import 'package:sharikiapp/widgets/home/post_time.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  @override
  void didChangeDependencies() {
    setState(() {
      isLoading = true;
    });
    final postProvider = Provider.of<PostProvider>(context);
    postProvider.fetchPosts();
    setState(() {
      isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final post = Provider.of<PostProvider>(context);
    return isLoading
        ? SplashScreen()
        : SingleChildScrollView(
            child: Column(
              children: [
                HomeSlider(),
                TextButton(
                    onPressed: () => auth.logout(), child: Text("Logout")),
                SizedBox(height: 10),
                Column(
                  children: [
                    _pageTitle("أحدث الشركاء"),
                    SizedBox(height: 10),
                    ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: post.posts.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => showModalBottomSheet(
                              context: context,
                              backgroundColor: whiteColor,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              builder: (context) => postInfo(
                                post.posts[index].title,
                                post.posts[index].requestedMajor,
                                post.posts[index].description),
                            ),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Container(
                                  height: 190,
                                  padding: EdgeInsets.only(
                                      right: 15, left: 15, top: 15),
                                  decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              PostImage(height: 60, width: 60),
                                              SizedBox(width: 5),
                                              Container(
                                                height: 55,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    PostTitle(title: post.posts[index].title),
                                                    PostCity(city: post.posts[index].city)
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          PostStatus(),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      PostDescription(
                                        description: post.posts[index].description,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 30),
                                      Container(
                                        height: 1,
                                        color: bgColor,
                                      ),
                                      SizedBox(height: 12),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          PostRequestedMajor(major: post.posts[index].requestedMajor,),
                                          PostTime(time: post.posts[index].time,)
                                          ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                  ],
                ),
              ],
            ),
          );
  }

  Widget postInfo(String title, String major, String description) {
    return Wrap(
      children: [
        Column(
          children: [
            SizedBox(height: 15),
            PostImage(height: 130, width: 130),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("الخبرات",
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold)),
                  PostRequestedMajor(major: major)
                ],
              ),
            ),
            Container(height: 1, color: bgColor),
            Padding(
              padding: EdgeInsets.only(right: 15, left: 15, top: 8, bottom: 8),
              child: PostDescription(
                description: description,
                overflow: TextOverflow.visible
                ),
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
}
