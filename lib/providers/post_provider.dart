import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sharikiapp/models/post.dart';
import 'package:http/http.dart' as http;

class PostProvider with ChangeNotifier {
  List<Post> _posts = [];
  List<Post> get posts => _posts;
  String baseUrl = "http://localhost:3000/";

  Future<dynamic> addNewPost(String publisherID, String publisherPhoneNumber,
      String title, String city, String requiredJob, String description, String postType) async {
    final url = Uri.parse(baseUrl + "api/posts/addnewpost");
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'publisherID': publisherID,
          'publisherPhoneNumber': publisherPhoneNumber,
          'title': title,
          'city': city,
          'requiredJob': requiredJob,
          'description': description,
          'postType': postType,
        }));

    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 201) {
      fetchPosts();
      notifyListeners();
      return jsonResponse['message'];
    } else {
      return jsonResponse['message'];
    }
  }

  Future<void> fetchPosts() async {
    final url = Uri.parse(baseUrl + "api/posts/fetchposts");
    final response = await http.get(url);
    final jsonResponse =
        jsonDecode(response.body)['posts'].cast<Map<String, dynamic>>();
    if (response.statusCode == 201) {
      _posts = jsonResponse.map<Post>((json) => Post.fromJson(json)).toList();
      notifyListeners();
    } else {
      return jsonResponse['message'];
    }
  }
}
