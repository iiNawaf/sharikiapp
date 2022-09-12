import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharikiapp/models/time.dart';
import 'package:sharikiapp/providers/auth_provider.dart';
import 'package:sharikiapp/providers/post_provider.dart';
import 'package:sharikiapp/screens/home/show_al_list.dart';
import 'package:sharikiapp/styles.dart';
import 'package:sharikiapp/widgets/shared_widgets/appbar.dart';
import 'package:sharikiapp/widgets/drawer.dart';
import 'package:sharikiapp/widgets/home/contact_btn.dart';
import 'package:sharikiapp/widgets/home/profile_preview.dart';
import 'package:sharikiapp/widgets/posts_widgets/post_city.dart';
import 'package:sharikiapp/widgets/posts_widgets/post_description.dart';
import 'package:sharikiapp/widgets/posts_widgets/post_image.dart';
import 'package:sharikiapp/widgets/posts_widgets/post_required_job.dart';
import 'package:sharikiapp/widgets/posts_widgets/post_status.dart';
import 'package:sharikiapp/widgets/posts_widgets/post_title.dart';
import 'package:sharikiapp/widgets/posts_widgets/post_time.dart';
import 'package:sharikiapp/widgets/posts_widgets/user_card.dart';
import 'package:sharikiapp/widgets/loading/fetching_data.dart';
import 'dart:async';

import 'package:sharikiapp/widgets/shared_widgets/shared_alert_dialog.dart';

class HomeScreen extends StatefulWidget {
  static final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      final postProvider = Provider.of<PostProvider>(context, listen: false);
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      postProvider.fetchPosts();
      authProvider.fetchUserInfo();
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
    _pageController.animateToPage(
      _currentPage,
      duration: Duration(milliseconds: 350),
      curve: Curves.easeIn,
    );
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
      onRefresh: () async{
        setState(() {
          isLoading = true;
        });
        await auth.fetchUserInfo();
        await post.fetchPosts();
        setState(() {
          isLoading = false;
        });
      },
      child: Scaffold(
        key: HomeScreen.scaffoldKey,
        drawer: isLoading ? Container() : HomeDrawer(title: "${auth.loggedInUser!.firstName} ${auth.loggedInUser!.lastName}", email: auth.loggedInUser!.email,),
        body: isLoading 
        ? FetchingDataLoading() 
        : CustomScrollView(
          slivers: <Widget>[
            HomeAppBar(title: "الرئيسية"),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text("تصفح الأفراد والمشاريع", style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 210,
                child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: auth.usersList!.length,
                  itemBuilder: (context, index){
                    return ProfilePreview(user: auth.usersList![index]);
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
                    Text("أحدث الاعلانات", style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold)),
                    post.posts.length > 10 ? GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAllList(posts: post.posts))),
                      child: Text("المزيد", style: TextStyle(color: primaryColor, fontSize: 16, fontWeight: FontWeight.bold))) : Container(),
                  ],
                )
              ),
            ),
            post.posts.length == 0 
            ? SliverToBoxAdapter(child: Center(child: Text("لا توجد نتائج"),),)
            : SliverToBoxAdapter(
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: post.posts.length > 10 ? 10 : post.posts.length,
                itemBuilder: (context, index){
                  DateTime date = DateTime.parse(post.posts[index].time).toUtc();
                  int timestamp = date.toLocal().millisecondsSinceEpoch;
                  var newDate = DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
                  return post.posts[index].postStatus != "active" 
                  ? Container() : Container(
                    padding: EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          if(post.posts[index].postStatus != "active"){
                            return;
                          }
                          showModalBottomSheet(
                          context: context,
                          backgroundColor: whiteColor,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          builder: (context) => postInfo(
                            post.posts[index].title,
                            post.posts[index].description,
                            post.posts[index].city,
                            post.posts[index].requiredJob,
                            post.posts[index].publisherPhoneNumber,
                          ),
                        );
                        
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(15)
                          ),
                          padding: EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        PostImage(height: 60, width: 60),
                                        SizedBox(width: 5),
                                        Container(
                                          height: 55,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              PostTitle(
                                                  title: post.posts[index].title),
                                              PostCity(city: post.posts[index].city)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    PostStatus(status: post.posts[index].postStatus)
                                  ],
                                ),
                                                              
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    PostRequiredJob(
                                        major: post.posts[index].requiredJob),
                                    PostTime(
                                      time: Time.displayTimeAgoFromTimestamp(
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

  Widget postInfo(
      String title, String description, String city, String requiredJob, String phoneNumber) {
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
                children: [
                  Text("المدينة",
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold)),
                  PostTitle(title: city)
                ],
              ),
            ),
            Container(height: 1, color: bgColor),
            Padding(
              padding:
                  const EdgeInsets.only(right: 15, left: 15, top: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("المجال العملي",
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold)),
                  PostTitle(title: requiredJob)
                ],
              ),
            ),
            Container(height: 1, color: bgColor),
            Padding(
              padding: EdgeInsets.only(right: 15, left: 15, top: 8, bottom: 8),
              child: PostDescription(
                  description: description, overflow: TextOverflow.visible),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ContactBtn(
                iconPath: './assets/icons/whatsapp.png',
                isWhatsApp: true,
                isPhoneCall: false,
                isVisitProfile: false,
                color: bgColor,
                phoneNumber: phoneNumber,
              ),
              SizedBox(width: 20),
              ContactBtn(
                iconPath: './assets/icons/external-link.png',
                isWhatsApp: false,
                isPhoneCall: false,
                isVisitProfile: true,
                color: bgColor,
                phoneNumber: phoneNumber,
              ),
              SizedBox(width: 20),
              ContactBtn(
                iconPath: './assets/icons/telephone.png',
                isWhatsApp: false,
                isPhoneCall: true,
                isVisitProfile: false,
                color: bgColor,
                phoneNumber: phoneNumber,
              ),
            ],
          ),
        ),
      ],
    );
  }
