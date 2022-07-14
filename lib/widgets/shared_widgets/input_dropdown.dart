import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharikiapp/styles.dart';
import 'dart:io' show Platform;

class InputDropDown extends StatefulWidget {
  static String selectedCity = "";
  static String selectedMajor = "";
  bool isCity;
  String title;
  List<String> list;
  InputDropDown({required this.title, required this.list, required this.isCity});
  @override
  State<InputDropDown> createState() => _InputDropDownState();
}

class _InputDropDownState extends State<InputDropDown> {
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
                      widget.isCity == true ? InputDropDown.selectedCity : InputDropDown.selectedMajor,
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
                        value: widget.isCity == true ? InputDropDown.selectedCity : InputDropDown.selectedMajor,
                        iconSize: 0.0,
                        underline: Container(),
                        onChanged: (String? newValue) {
                          if(widget.isCity == true){
                            setState(() {
                            InputDropDown.selectedCity = newValue!;
                          });
                          }else{
                            setState(() {
                            InputDropDown.selectedMajor = newValue!;
                          });
                          }
                          
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
                  if(widget.isCity == true){
                    setState(() {
                      InputDropDown.selectedCity = widget.list[value].toString();
                    });
                  }else{
                    setState(() {
                      InputDropDown.selectedMajor = widget.list[value].toString();
                    });
                  }
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
                  if(widget.isCity == true){
                    setState(() {
                      InputDropDown.selectedCity = widget.list[value].toString();
                    });
                  }else{
                    setState(() {
                      InputDropDown.selectedMajor = widget.list[value].toString();
                    });
                  }
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
