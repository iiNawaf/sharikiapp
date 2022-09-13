import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:provider/provider.dart';
import 'package:sharikiapp/models/time.dart';
import 'package:sharikiapp/models/user.dart';
import 'package:sharikiapp/providers/auth_provider.dart';
import 'package:sharikiapp/providers/post_provider.dart';
import 'package:sharikiapp/screens/home/home.dart';
import 'package:sharikiapp/styles.dart';
import 'package:sharikiapp/widgets/shared_widgets/appbar.dart';
import 'package:sharikiapp/widgets/posts_widgets/post_city.dart';
import 'package:sharikiapp/widgets/posts_widgets/post_image.dart';
import 'package:sharikiapp/widgets/posts_widgets/post_required_job.dart';
import 'package:sharikiapp/widgets/posts_widgets/post_status.dart';
import 'package:sharikiapp/widgets/posts_widgets/post_time.dart';
import 'package:sharikiapp/widgets/posts_widgets/post_title.dart';

class MyPosts extends StatefulWidget {
  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  @override
  Widget build(BuildContext context) {
    final post = Provider.of<PostProvider>(context);
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: SharedAppBar(
            title: "طلباتي",
          )),
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: post.posts.length,
          itemBuilder: (ctx, index) {
            DateTime date = DateTime.parse(post.posts[index].time).toUtc();
            int timestamp = date.toLocal().millisecondsSinceEpoch;
            var newDate = DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
            return auth.loggedInUser!.id == post.posts[index].publisherID
                ? Container(
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
                                post.posts[index].publisherPhoneNumber,
                                post.posts[index].publisherProfileImage,
                                post.posts[index].postType
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
                                        PostImage(height: 60, width: 60, img: post.posts[index].publisherProfileImage,),
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
                                                      post.posts[index].title),
                                              PostCity(
                                                  city: post.posts[index].city)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    PostStatus(
                                        status: post.posts[index].postStatus)
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
                        ))
                : Container();
          },
        ),
      ),
    );
  }
}
