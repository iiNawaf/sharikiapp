import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharikiapp/models/time.dart';
import 'package:sharikiapp/models/user.dart';
import 'package:sharikiapp/providers/post_provider.dart';
import 'package:sharikiapp/screens/home/home.dart';
import 'package:sharikiapp/styles.dart';
import 'package:sharikiapp/widgets/appbar.dart';
import 'package:sharikiapp/widgets/home/contact_btn.dart';
import 'package:sharikiapp/widgets/home/post_city.dart';
import 'package:sharikiapp/widgets/home/post_image.dart';
import 'package:sharikiapp/widgets/home/post_required_job.dart';
import 'package:sharikiapp/widgets/home/post_time.dart';
import 'package:sharikiapp/widgets/home/post_title.dart';
import 'package:sharikiapp/widgets/profile/profile_image.dart';

class UserProfile extends StatelessWidget {
  User user;
  UserProfile({required this.user});

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<PostProvider>(context, listen: false);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: SharedAppBar(title: "${user.firstName} ${user.lastName}"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: ProfileImage(
                            image: NetworkImage(user.profileImage)),
                      ),
                      SizedBox(height: 20),
                      Text(
                        user.bio == "" ? "لا يوجد وصف" : "${user.bio}",
                        style: TextStyle(color: textColor),
                      ),
                      SizedBox(height: 10),
                      Text("${user.city}", style: TextStyle(color: textColor)),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ContactBtn(
                            iconPath: './assets/icons/whatsapp.png',
                            isWhatsApp: true,
                            isPhoneCall: false,
                            isVisitProfile: false,
                            color: bgColor,
                            phoneNumber: user.phoneNumber,
                          ),
                          SizedBox(width: 20),
                          ContactBtn(
                            iconPath: './assets/icons/telephone.png',
                            isWhatsApp: false,
                            isPhoneCall: true,
                            isVisitProfile: false,
                            color: bgColor,
                            phoneNumber: user.phoneNumber,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "اعلانات ${user.firstName}",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: post.posts.length,
                    itemBuilder: (ctx, index) {
                      DateTime date =
                          DateTime.parse(post.posts[index].time).toUtc();
                      int timestamp = date.toLocal().millisecondsSinceEpoch;
                      var newDate =
                          DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
                      return user.id == post.posts[index].publisherID
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
                                    post.posts[index].publisherPhoneNumber
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  padding: EdgeInsets.all(15),
                                  child: Column(
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
                                                PostTitle(
                                                    title: post
                                                        .posts[index].title),
                                                PostCity(
                                                    city:
                                                        post.posts[index].city)
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
                                              major: post
                                                  .posts[index].requiredJob),
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
                              ))
                          : Container();
                    })
              ],
            ),
          ),
        ));
  }
}