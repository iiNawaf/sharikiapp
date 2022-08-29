import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharikiapp/models/time.dart';
import 'package:sharikiapp/providers/auth_provider.dart';
import 'package:sharikiapp/providers/post_provider.dart';
import 'package:sharikiapp/screens/splash/splash.dart';
import 'package:sharikiapp/styles.dart';
import 'package:sharikiapp/widgets/appbar.dart';
import 'package:sharikiapp/widgets/drawer.dart';
import 'package:sharikiapp/widgets/home/contact_btn.dart';
import 'package:sharikiapp/widgets/home/home_option.dart';
import 'package:sharikiapp/widgets/home/post_city.dart';
import 'package:sharikiapp/widgets/home/post_description.dart';
import 'package:sharikiapp/widgets/home/post_image.dart';
import 'package:sharikiapp/widgets/home/post_required_job.dart';
import 'package:sharikiapp/widgets/home/post_title.dart';
import 'package:sharikiapp/widgets/home/post_time.dart';

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
      final postProvider = Provider.of<PostProvider>(context);
      postProvider.fetchPosts();
      setState(() {
        isLoading = false;
      });
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final post = Provider.of<PostProvider>(context);
    return Scaffold(
      key: HomeScreen.scaffoldKey,
      drawer: HomeDrawer(title: "${auth.loggedInUser!.firstName} ${auth.loggedInUser!.lastName}", email: auth.loggedInUser!.email,),
      body: CustomScrollView(
        slivers: <Widget>[
          HomeAppBar(title: "الرئيسية"),
          //individual results
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text("تصفح الأفراد", style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 120,
              child: ListView.builder(
                itemCount: post.posts.length > 10 ? 10 : post.posts.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: ((context, index){
                  return post.posts[index].postType == "individual" 
                  ? HomeOption(post: post.posts[index]) : Container();
                }
                ),
              ),
            )
          ),
          //project results
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text("تصفح المشاريع", style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 120,
              child: ListView.builder(
                itemCount: post.posts.length > 10 ? 10 : post.posts.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: ((context, index){
                  return post.posts[index].postType == "project" 
                  ? HomeOption(post: post.posts[index]) : Container();
                }
                ),
              ),
            )
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text("أحدث الاعلانات", style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
          post.posts.length == 0 
          ? SliverToBoxAdapter(child: Center(child: Text("لا توجد نتائج"),),)
          : SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                var reversedPosts = post.posts.reversed;
                DateTime date = DateTime.parse(post.posts[index].time).toUtc();
                int timestamp = date.toLocal().millisecondsSinceEpoch;
                var newDate = DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
                return Container(
                  padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () => showModalBottomSheet(
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
                        ),
                      ),
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
              childCount: post.posts.length > 10 ? 10 : post.posts.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget postInfo(
      String title, String description, String city, String requiredJob) {
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
              ),
              SizedBox(width: 20),
              ContactBtn(
                iconPath: './assets/icons/external-link.png',
                isWhatsApp: false,
                isPhoneCall: false,
                isVisitProfile: true,
              ),
              SizedBox(width: 20),
              ContactBtn(
                iconPath: './assets/icons/telephone.png',
                isWhatsApp: false,
                isPhoneCall: true,
                isVisitProfile: false,
              ),
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
