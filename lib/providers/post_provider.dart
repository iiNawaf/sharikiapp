import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sharikiapp/models/post.dart';
import 'package:http/http.dart' as http;

class PostProvider with ChangeNotifier{
  List<Post> _posts = [];
  List<Post> get posts => _posts;
  String baseUrl = "http://10.0.2.2:3000/";

  Future<void> addNewPost(String publisherID, int publisherPhoneNumber, String title, String requestedMajor, String city, String description) async{
    final url = Uri.parse(baseUrl + "api/posts/addnewpost");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'publisherID': publisherID,
        'publisher': publisherPhoneNumber,
        'title': title,
        'requestedMajor': requestedMajor,
        'city': city,
        'description': description
      })
      );

      final jsonResponse = jsonDecode(response.body);

      if(response.statusCode == 201){
        fetchPosts();
      }else{
        return jsonResponse['message'];
      }
  }

  Future<void> fetchPosts() async{
    final url = Uri.parse(baseUrl + "api/posts/fetchposts");
    final response = await http.get(url);
    final jsonResponse = jsonDecode(response.body)['posts'].cast<Map<String, dynamic>>();

    if(response.statusCode == 201){
      _posts = jsonResponse.map<Post>((json) => Post.fromJson(json)).toList();
      notifyListeners();
    }else{
      return jsonResponse['message'];
    }
  }


}