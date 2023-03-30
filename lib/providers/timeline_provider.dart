import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sharikiapp/services/api/api_services.dart';
import 'package:http/http.dart' as http;

class TimelineProvider with ChangeNotifier {
  ApiServices apiServices = ApiServices();

  Future<void> addNewTimeline(String publisherID, String publisherName,
      String publisherImage, String content) async {
    final url = Uri.parse(apiServices.baseUrl + "api/timeline/add_timeline");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'publisherID': publisherID,
        'publisherName': publisherName,
        'publisherImage': publisherName,
        'content': content
      })
    );
    if(response.statusCode == 201){
      print("Good");
    }
  }
}
