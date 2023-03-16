import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharikiapp/models/time.dart';
import 'package:sharikiapp/providers/auth_provider.dart';
import 'package:sharikiapp/providers/post_provider.dart';
import 'package:sharikiapp/styles/constant_styles.dart';
import 'package:sharikiapp/widgets/loading/fetching_data.dart';
import 'package:sharikiapp/widgets/shared_widgets/appbar.dart';
import 'package:sharikiapp/widgets/posts_widgets/post_city.dart';
import 'package:sharikiapp/widgets/posts_widgets/post_image.dart';
import 'package:sharikiapp/widgets/posts_widgets/post_required_job.dart';
import 'package:sharikiapp/widgets/posts_widgets/post_status.dart';
import 'package:sharikiapp/widgets/posts_widgets/post_time.dart';
import 'package:sharikiapp/widgets/posts_widgets/post_title.dart';
import 'package:sharikiapp/widgets/shared_widgets/post_info.dart';

class MyPosts extends StatefulWidget {
  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  bool isLoading = false;
  bool isInit = true;
  @override
  void didChangeDependencies() async{
    if(isInit){
      setState(() {
        isLoading = true;
      });
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final postProvider = Provider.of<PostProvider>(context, listen: false);
      postProvider.fetchMyPosts(authProvider.loggedInUser!.id);
      setState(() {
        isLoading = false;
      });
    }else{
      setState(() {
        isLoading = false;
      });
    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final post = Provider.of<PostProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: SharedAppBar(
            title: "اعلاناتي",
          )),
      body: isLoading 
      ? FetchingDataLoading() 
      : SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: post.myPosts.length,
          itemBuilder: (ctx, index) {
            DateTime date = DateTime.parse(post.myPosts[index].time).toUtc();
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
                            builder: (context) => PostInfo(
                                title: post.myPosts[index].title,
                                description: post.myPosts[index].description,
                                city: post.myPosts[index].city,
                                requiredJob: post.myPosts[index].requiredJob,
                                phoneNumber: post.myPosts[index].publisherPhoneNumber,
                                image: post.myPosts[index].publisherProfileImage,
                                accountType: post.myPosts[index].postType
                                ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(15)),
                            padding: EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        PostImage(height: 60, width: 60, img: post.myPosts[index].publisherProfileImage,),
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
                                                  title:
                                                      post.myPosts[index].title),
                                              PostCity(
                                                  city: post.myPosts[index].city)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    PostStatus(
                                        status: post.myPosts[index].postStatus)
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    PostRequiredJob(
                                        major: post.myPosts[index].requiredJob),
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
      ),
    );
  }
}
