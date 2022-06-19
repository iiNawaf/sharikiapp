import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharikiapp/models/user.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  User? _loggedInUser;
  User? get loggedInUser => _loggedInUser;
  String baseUrl = "http://10.0.2.2:3000/";

  Future<String> login(String email, String password) async {
    final url = Uri.parse(baseUrl + "api/auth/login");
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body:
            jsonEncode(<String, String>{'email': email, 'password': password}));

    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 201) {
      try {
        _loggedInUser = User(
            id: jsonResponse['user']['id'],
            firstName: jsonResponse['user']['firstName'],
            lastName: jsonResponse['user']['lastName'],
            email: jsonResponse['user']['email'],
            bio: jsonResponse['user']['bio'],
            profileImage: jsonResponse['user']['profileImage'],
            city: jsonResponse['user']['city'],
            phoneNumber: jsonResponse['user']['phoneNumber'],
            accountType: jsonResponse['user']['accountType'],
            majors: jsonResponse['user']['majors'],
            createdAt: jsonResponse['user']['createdAt']);

        final loggedInUserInfo = jsonEncode({
          'id': jsonResponse['user']['id'],
          'firstName': jsonResponse['user']['firstName'],
          'lastName': jsonResponse['user']['lastName'],
          'email': jsonResponse['user']['email'],
          'bio': jsonResponse['user']['bio'],
          'profileImage': jsonResponse['user']['profileImage'],
          'city': jsonResponse['user']['city'],
          'phoneNumber': jsonResponse['user']['phoneNumber'],
          'accountType': jsonResponse['user']['accountType'],
          'majors': jsonResponse['user']['majors'],
          'createdAt': jsonResponse['user']['createdAt']
        });

        final storage = await SharedPreferences.getInstance();
        await storage.setString("userInfo", loggedInUserInfo);
        notifyListeners();

        return "";
      } catch (e) {
        print("Error occurred: $e");
      }

    } else {
      return jsonResponse['message'];
    }
    return "";
  }

  Future<String> signUp(String firstName, String lastName, String email,
      String phoneNumber, String password, String accountType) async {
    final url = Uri.parse(baseUrl + "api/auth/signup");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'bio': "",
        'profileImage': "",
        'phoneNumber': phoneNumber,
        'password': password,
        'accountType': accountType,
        'city': "",
      }),
    );

    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 201) {
      try {
        _loggedInUser = User(
            id: jsonResponse['user']['id'],
            firstName: jsonResponse['user']['firstName'],
            lastName: jsonResponse['user']['lastName'],
            email: jsonResponse['user']['email'],
            bio: jsonResponse['user']['bio'],
            profileImage: jsonResponse['user']['profileImage'],
            city: jsonResponse['user']['city'],
            phoneNumber: jsonResponse['user']['phoneNumber'],
            accountType: jsonResponse['user']['accountType'],
            majors: jsonResponse['user']['majors'],
            createdAt: jsonResponse['user']['createdAt']);
        
        final createdUserInfo = jsonEncode({
          'id': jsonResponse['user']['id'],
          'firstName': jsonResponse['user']['firstName'],
          'lastName': jsonResponse['user']['lastName'],
          'email': jsonResponse['user']['email'],
          'bio': jsonResponse['user']['bio'],
          'profileImage': jsonResponse['user']['profileImage'],
          'city': jsonResponse['user']['city'],
          'phoneNumber': jsonResponse['user']['phoneNumber'],
          'accountType': jsonResponse['user']['accountType'],
          'majors': jsonResponse['user']['majors'],
          'createdAt': jsonResponse['user']['createdAt']
        });

        final storage = await SharedPreferences.getInstance();
        storage.setString("userInfo", createdUserInfo);
        notifyListeners();

        return "";
      } catch (e) {
        print("Error occurred $e");
      }
    } else {
      return jsonResponse['message'];
    }
    return "";
  }

  Future<bool> isLoggedInUser() async {
    final storage = await SharedPreferences.getInstance();
    if (!storage.containsKey("userInfo")) {
      print("User not found!");
      return false;
    } else {
      print("User found!");
      final extractedUserInfo = jsonDecode("${storage.getString("userInfo")}");
      _loggedInUser = User(
        id: extractedUserInfo['id'],
        firstName: extractedUserInfo['firstName'],
        lastName: extractedUserInfo['lastName'],
        email: extractedUserInfo['email'],
        bio: extractedUserInfo['bio'],
        profileImage: extractedUserInfo['profileImage'],
        city: extractedUserInfo['city'],
        phoneNumber: extractedUserInfo['phoneNumber'],
        accountType: extractedUserInfo['accountType'],
        majors: extractedUserInfo['majors'],
        createdAt: extractedUserInfo['createdAt'],
      );
      return true;
    }
  }

  void logout() async {
    final storage = await SharedPreferences.getInstance();
    storage.clear();
    _loggedInUser = null;
    notifyListeners();
  }
}
