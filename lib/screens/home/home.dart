import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharikiapp/models/time.dart';
import 'package:sharikiapp/providers/auth_provider.dart';
import 'package:sharikiapp/providers/post_provider.dart';
import 'package:sharikiapp/screens/home/show_all_list.dart';
import 'package:sharikiapp/services/functions/navigations.dart';
import 'package:sharikiapp/styles/constant_styles.dart';
import 'package:sharikiapp/widgets/shared_widgets/appbar.dart';
import 'package:sharikiapp/widgets/drawer.dart';
import 'package:sharikiapp/widgets/home/profile_preview.dart';
import 'package:sharikiapp/widgets/posts_widgets/post_city.dart';
import 'package:sharikiapp/widgets/posts_widgets/post_image.dart';
import 'package:sharikiapp/widgets/posts_widgets/post_required_job.dart';
import 'package:sharikiapp/widgets/posts_widgets/post_status.dart';
import 'package:sharikiapp/widgets/posts_widgets/post_title.dart';
import 'package:sharikiapp/widgets/posts_widgets/post_time.dart';
import 'package:sharikiapp/widgets/loading/fetching_data.dart';
import 'dart:async';

import 'package:sharikiapp/widgets/shared_widgets/post_info.dart';

class HomeScreen extends StatefulWidget {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>();
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  bool isInit = true;
  @override
  void didChangeDependencies() async{
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      final postProvider = Provider.of<PostProvider>(context, listen: false);
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await postProvider.fetchPosts(authProvider.loggedInUser!.accountType);
      await authProvider.fetchUserInfo();
      setState(() {
        isLoading = false;
      });
      isInit = false;
    }
    super.didChangeDependencies();
  }

  int _currentPage = 0;
  late Timer _timer;
  PageController _pageController = PageController(
    initialPage: 0,
  );
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final post = Provider.of<PostProvider>(context);
    return RefreshIndicator(
      displacement: 200,
      strokeWidth: 2,
      color: primaryColor,
      onRefresh: () async {
        setState(() {
          isLoading = true;
        });
        await auth.fetchUserInfo();
        await post.fetchPosts(auth.loggedInUser!.accountType);
        setState(() {
          isLoading = false;
        });
      },
      child: Scaffold(
        key: HomeScreen.scaffoldKey,
        drawer: isLoading
            ? Container()
            : HomeDrawer(
                title:
                    "${auth.loggedInUser!.firstName} ${auth.loggedInUser!.lastName}",
                email: auth.loggedInUser!.email,
              ),
        body: isLoading
            ? FetchingDataLoading()
            : CustomScrollView(
                slivers: <Widget>[
                  HomeAppBar(title: "الرئيسية"),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                          auth.loggedInUser!.accountType == 'individual'
                              ? "تصفح المشاريع"
                              : "تصفح الأفراد",
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                  ),
                  auth.usersList!.length == 0
                      ? SliverToBoxAdapter(
                          child: Center(
                            child: Text("لا توجد نتائج"),
                          ),
                        )
                      : SliverToBoxAdapter(
                          child: Container(
                            height: 215,
                            child: PageView.builder(
                              controller: _pageController,
                              scrollDirection: Axis.horizontal,
                              itemCount: auth.usersList!.length,
                              itemBuilder: (context, index) {
                                return auth.isLoading
                                    ? Container(
                                        height: 100,
                                        decoration: BoxDecoration(
                                            color: whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      )
                                    : ProfilePreview(
                                        user: auth.usersList![index]);
                              },
                            ),
                          ),
                        ),
                  SliverToBoxAdapter(
                    child: Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                auth.loggedInUser!.accountType == 'individual'
                                    ? "أحدث اعلانات المشاريع"
                                    : "أحدث اعلانات الأفراد",
                                style: Theme.of(context).textTheme.titleMedium),
                            post.posts.length > 10
                                ? GestureDetector(
                                    onTap: () => navigateTo(context, ShowAllList(
                                                posts: post.posts)),
                                    child: Text("المزيد",
                                        style: Theme.of(context).textTheme.titleSmall))
                                : Container(),
                          ],
                        )),
                  ),
                  post.posts.length == 0
                      ? SliverToBoxAdapter(
                          child: Center(
                            child: Text("لا توجد نتائج"),
                          ),
                        )
                      : SliverToBoxAdapter(
                          child: ListView.builder(
                            padding: EdgeInsets.all(0),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                post.posts.length > 10 ? 10 : post.posts.length,
                            itemBuilder: (context, index) {
                              DateTime date =
                                  DateTime.parse(post.posts[index].time)
                                      .toUtc();
                              int timestamp =
                                  date.toLocal().millisecondsSinceEpoch;
                              var newDate = DateTime.fromMicrosecondsSinceEpoch(
                                  timestamp * 1000);
                              return post.isLoading
                                  ? Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                          color: whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    )
                                  : Container(
                                      padding: EdgeInsets.all(10),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (post.posts[index].postStatus !=
                                              "active") {
                                            return;
                                          }
                                          showModalBottomSheet(
                                            context: context,
                                            backgroundColor: whiteColor,
                                            isScrollControlled: true,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            builder: (context) => PostInfo(
                                                title: post.posts[index].title,
                                                description: post.posts[index].description,
                                                city: post.posts[index].city,
                                                requiredJob: post.posts[index].requiredJob,
                                                phoneNumber: post.posts[index]
                                                    .publisherPhoneNumber,
                                                image: post.posts[index]
                                                    .publisherProfileImage,
                                                accountType: post.posts[index].postType),
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                                boxShadow: [containerBoxShadow]
                                          ),
                                          padding: EdgeInsets.all(15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      PostImage(
                                                        height: 60,
                                                        width: 60,
                                                        img: post.posts[index]
                                                            .publisherProfileImage,
                                                      ),
                                                      SizedBox(width: 5),
                                                      Container(
                                                        height: 55,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            PostTitle(
                                                                title:
                                                                    "${post.posts[index].title}"),
                                                            PostCity(
                                                                city: post
                                                                    .posts[
                                                                        index]
                                                                    .city)
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  PostStatus(
                                                      status: post.posts[index]
                                                          .postStatus)
                                                ],
                                              ),
                                              SizedBox(height: 20),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  PostRequiredJob(
                                                      major: post.posts[index]
                                                          .requiredJob),
                                                  PostTime(
                                                    time: Time
                                                        .displayTimeAgoFromTimestamp(
                                                            newDate.toString()),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ));
                            },
                          ),
                        )
                ],
              ),
      ),
    );
  }
}
