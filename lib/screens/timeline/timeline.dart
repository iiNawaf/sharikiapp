import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharikiapp/providers/auth_provider.dart';
import 'package:sharikiapp/providers/timeline_provider.dart';
import 'package:sharikiapp/services/functions/navigations.dart';
import 'package:sharikiapp/services/functions/show_alert_dialog.dart';
import 'package:sharikiapp/styles/constant_styles.dart';
import 'package:sharikiapp/widgets/loading/button_loading.dart';
import 'package:sharikiapp/widgets/shared_widgets/appbar.dart';
import 'package:sharikiapp/widgets/shared_widgets/input_text_field.dart';
import 'package:sharikiapp/widgets/timeline/timeline_post_content.dart';
import 'package:sharikiapp/widgets/timeline/timeline_post_image.dart';
import 'package:sharikiapp/widgets/timeline/timeline_post_time.dart';
import 'package:sharikiapp/widgets/timeline/timeline_post_title.dart';

class TimelineScreen extends StatefulWidget {
  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  TextEditingController _timelineMessageController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final timeline = Provider.of<TimelineProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SharedAppBar(
            title: "المنشورات",
            leading: IconButton(
              onPressed: () {
                if (!isLoading) {
                  showAlertDialog(
                      context,
                      false,
                      "ارسال منشور",
                      InputTextField(
                          title: "اكتب هنا...",
                          isObsecure: false,
                          controller: _timelineMessageController,
                          maxLines: 300,
                          maxLength: 240,
                          inputType: TextInputType.text),
                      "ارسال",
                      "رجوع", () async {
                    setState(() {
                      isLoading = true;
                    });
                    await timeline.addNewTimeline(
                        auth.loggedInUser!.id,
                        auth.loggedInUser!.firstName +
                            " " +
                            auth.loggedInUser!.lastName,
                        auth.loggedInUser!.profileImage,
                        _timelineMessageController.text);
                    setState(() {
                      isLoading = false;
                    });
                  }, () => navigateBack(context));
                } else {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => ButtonLoading());
                }
              },
              icon: Icon(Icons.add, color: primaryColor),
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [containerBoxShadow]),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        TimelinePostImage(),
                        SizedBox(width: 10),
                        TimelinePostTitle(),
                      ],
                    ),
                    TimelinePostTime()
                  ],
                ),
                TimelinePostContent(),
                // ContactBtn(
                //   iconPath: './assets/icons/whatsapp.png',
                //   isPhoneCall: false,
                //   isVisitProfile: false,
                //   isWhatsApp: true,
                //   color: bgColor,
                //   phoneNumber: "0594789491"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
