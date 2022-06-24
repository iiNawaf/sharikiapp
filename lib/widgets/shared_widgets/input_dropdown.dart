import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';
import 'dart:io' show Platform;

class InputDropDown extends StatefulWidget {
  static String selectedValue = "";
  String title;
  List<String> list;
  String val;
  InputDropDown({required this.title, required this.list, required this.val});
  @override
  State<InputDropDown> createState() => _InputDropDownState();
}

class _InputDropDownState extends State<InputDropDown> {

  @override
  void initState() {
    InputDropDown.selectedValue = widget.val;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? GestureDetector(
            onTap: () => showIOSPicker(context),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                  color: whiteColor, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      InputDropDown.selectedValue,
                      style: TextStyle(
                          fontSize: 16,
                          color: inputTextColor),
                    ),
                    Image.asset('./assets/icons/down.png')
                  ],
                ),
              ),
            ),
          )
        : Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: whiteColor, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: DropdownButton(
                        value: InputDropDown.selectedValue,
                        iconSize: 0.0,
                        underline: Container(),
                        onChanged: (String? newValue) {
                          setState(() {
                            InputDropDown.selectedValue = newValue!;
                          });
                        },
                        items: widget.list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value == "" ? widget.title : value,
                              style: TextStyle(
                                  color: inputTextColor,
                                  fontSize: 16,
                                  ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Image.asset('./assets/icons/down.png')
                  ],
                ),
              ),
            ),
          );
  }

  void showIOSPicker(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
              height: MediaQuery.of(context).copyWith().size.height * 0.25,
              color: Colors.white,
              child: CupertinoPicker(
                children: widget.list.map((e) => Text(e)).toList(),
                onSelectedItemChanged: (value) {
                  InputDropDown.selectedValue = widget.list[value].toString();
                  setState(() {});
                },
                itemExtent: 30,
                diameterRatio: 1,
                useMagnifier: true,
                magnification: 1.3,
                looping: true,
              ));
        });
  }

  void showAndroidPicker(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
              height: MediaQuery.of(context).copyWith().size.height * 0.25,
              color: Colors.white,
              child: CupertinoPicker(
                children: widget.list.map((e) => Text(e)).toList(),
                onSelectedItemChanged: (value) {
                  InputDropDown.selectedValue = widget.list[value].toString();
                  setState(() {});
                },
                itemExtent: 30,
                diameterRatio: 1,
                useMagnifier: true,
                magnification: 1.3,
                looping: true,
              ));
        });
  }
}
