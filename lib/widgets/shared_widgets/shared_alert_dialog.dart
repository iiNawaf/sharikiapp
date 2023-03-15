import 'package:flutter/material.dart';
import 'package:sharikiapp/utilities/styles/constant_styles.dart';

class SharedAlertDialog extends StatelessWidget {
  String title;
  String content;
  String btnTitle;
  String btnTitle2;
  Function() click;
  Function() click2;
  SharedAlertDialog(
      {required this.title,
      required this.content,
      required this.btnTitle,
      required this.btnTitle2,
      required this.click,
      required this.click2});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text(
          title,
          style: TextStyle(fontSize: 18, color: primaryColor),
        ),
        content: Text(
          content,
          style: TextStyle(color: textColor, fontSize: 14),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        actions: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
            onTap: click,
            child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: primaryColor, borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    btnTitle,
                    style: TextStyle(color: whiteColor),
                  ),
                ),
            ),
          ),
              ),
              SizedBox(width: 10,),
          btnTitle2 != ""
              ? Expanded(
                child: GestureDetector(
                    onTap: click2,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          btnTitle2,
                          style: TextStyle(color: whiteColor),
                        ),
                      ),
                    ),
                  ),
              )
              : Container(),
            ],
          )
        ],
      ),
    );
  }
}
