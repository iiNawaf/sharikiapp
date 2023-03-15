import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharikiapp/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:sharikiapp/services/api_services.dart';

class PostProvider with ChangeNotifier {
  ApiServices apiServices = ApiServices();
  List<Post> _posts = [];
  List<Post> _myPosts = [];
  List<Post> get posts => _posts;
  List<Post> get myPosts => _myPosts;
  bool isLoading = false;

  Future<dynamic> addNewPost(
      String publisherID,
      String publisherPhoneNumber,
      String publisherProfileImage,
      String title,
      String city,
      String requiredJob,
      String description,
      String postType) async {
    final storage = await SharedPreferences.getInstance();
    if (storage.containsKey("token")) {
      final url = Uri.parse(
          apiServices.baseUrl + "api/posts/addnewpost");
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": "Bearer ${storage.getString("token")!}"
          },
          body: jsonEncode(<String, dynamic>{
            'publisherID': publisherID,
            'publisherPhoneNumber': publisherPhoneNumber,
            'publisherProfileImage': publisherProfileImage,
            'title': title,
            'city': city,
            'requiredJob': requiredJob,
            'description': description,
            'postStatus': "active",
            'postType': postType,
          }));

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 201) {
        fetchPosts(postType);
        notifyListeners();
        return jsonResponse['message'];
      } else {
        return jsonResponse['message'];
      }
    }
  }

  Future<void> fetchPosts(String accountType) async {
    final storage = await SharedPreferences.getInstance();
    isLoading = true;
    if (storage.containsKey("token")) {
      final url = Uri.parse(
        apiServices.baseUrl +
            "api/posts/fetchposts/$accountType",
      );
      final response = await http.get(url,
          headers: {"Authorization": "Bearer ${storage.getString("token")!}"});
      if (response.statusCode == 201) {
        final jsonResponse =
            jsonDecode(response.body)['posts'].cast<Map<String, dynamic>>();
        _posts = jsonResponse.map<Post>((json) => Post.fromJson(json)).toList();
        notifyListeners();
      } else {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse['message']);
      }
      isLoading = false;
    } else {
      isLoading = false;
    }
  }

  Future<void> fetchMyPosts(String id) async {
    final storage = await SharedPreferences.getInstance();
    isLoading = true;
    if (storage.containsKey("token")) {
      final url = Uri.parse(apiServices.baseUrl +
          "api/posts/fetchposts/myposts/$id");
      final response = await http.get(url,
          headers: {"Authorization": "Bearer ${storage.getString("token")!}"});

      if (response.statusCode == 201) {
        final jsonResponse =
            jsonDecode(response.body)['posts'].cast<Map<String, dynamic>>();
        _myPosts =
            jsonResponse.map<Post>((json) => Post.fromJson(json)).toList();
        notifyListeners();
      } else {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse['message'];
      }
      isLoading = false;
    } else {
      isLoading = false;
    }
  }
}
