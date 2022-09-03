import 'package:flutter/material.dart';
import 'package:sharikiapp/models/post.dart';
import 'package:sharikiapp/models/time.dart';
import 'package:sharikiapp/screens/home/home.dart';
import 'package:sharikiapp/styles.dart';
import 'package:sharikiapp/widgets/appbar.dart';
import 'package:sharikiapp/widgets/home/post_city.dart';
import 'package:sharikiapp/widgets/home/post_image.dart';
import 'package:sharikiapp/widgets/home/post_required_job.dart';
import 'package:sharikiapp/widgets/home/post_time.dart';
import 'package:sharikiapp/widgets/home/post_title.dart';

class ShowAllList extends StatelessWidget {
  List<Post> posts;
  ShowAllList({required this.posts});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: SharedAppBar(
            title: "جميع الاعلانات",
          )),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: ListView.builder(
            reverse: true,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: posts.length,
            itemBuilder: (ctx, index) {
              DateTime date = DateTime.parse(posts[index].time).toUtc();
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
                        posts[index].title,
                        posts[index].description,
                        posts[index].city,
                        posts[index].requiredJob,
                        posts[index].publisherPhoneNumber
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PostImage(height: 60, width: 60),
                              SizedBox(width: 5),
                              Container(
                                height: 55,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    PostTitle(title: posts[index].title),
                                    PostCity(city: posts[index].city)
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PostRequiredJob(
                                  major: posts[index].requiredJob),
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
      ),
    );
  }
}
