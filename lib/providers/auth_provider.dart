import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharikiapp/models/user.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  User? _loggedInUser;
  User? get loggedInUser => _loggedInUser;
  String baseUrl = "http://10.0.2.2:3000/";

  Future<dynamic> login(String email, String password) async {
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
            id: jsonResponse['user']['_id'],
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
          'id': jsonResponse['user']['_id'],
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

  Future<dynamic> signUp(String firstName, String lastName, String email,
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
            id: jsonResponse['user']['_id'],
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
          'id': jsonResponse['user']['_id'],
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

  Future<dynamic> updateUserProfileInfo(String firstName, String lastName,
      String bio, String phoneNumber, String city, List<dynamic> majors) async {
    if (isUserInfoChanged(
            firstName, lastName, bio, phoneNumber, city, majors) ==
        false) {
      return "لم تجري أي تغييرات";
    }
    final url =
        Uri.parse(baseUrl + "api/auth/updateuserinfo/${_loggedInUser!.id}");
    final response = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'firstName': firstName,
          'lastName': lastName,
          'bio': bio,
          'phoneNumber': phoneNumber,
          'city': city,
          'majors': majors
        }));

    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 201) {
      try {
        _loggedInUser = User(
            id: jsonResponse['updatedUser']['_id'],
            firstName: jsonResponse['updatedUser']['firstName'],
            lastName: jsonResponse['updatedUser']['lastName'],
            email: jsonResponse['updatedUser']['email'],
            bio: jsonResponse['updatedUser']['bio'],
            profileImage: jsonResponse['updatedUser']['profileImage'],
            city: jsonResponse['updatedUser']['city'],
            phoneNumber: jsonResponse['updatedUser']['phoneNumber'],
            accountType: jsonResponse['updatedUser']['accountType'],
            majors: jsonResponse['updatedUser']['majors'],
            createdAt: jsonResponse['updatedUser']['createdAt']);

        final updatedUserInfo = jsonEncode({
          'id': jsonResponse['updatedUser']['_id'],
          'firstName': jsonResponse['updatedUser']['firstName'],
          'lastName': jsonResponse['updatedUser']['lastName'],
          'email': jsonResponse['updatedUser']['email'],
          'bio': jsonResponse['updatedUser']['bio'],
          'profileImage': jsonResponse['updatedUser']['profileImage'],
          'city': jsonResponse['updatedUser']['city'],
          'phoneNumber': jsonResponse['updatedUser']['phoneNumber'],
          'accountType': jsonResponse['updatedUser']['accountType'],
          'majors': jsonResponse['updatedUser']['majors'],
          'createdAt': jsonResponse['updatedUser']['createdAt']
        });

        final currentStorage = await SharedPreferences.getInstance();
        currentStorage.remove("userInfo");

        final newStorage = await SharedPreferences.getInstance();
        newStorage.setString("userInfo", updatedUserInfo);
        notifyListeners();
        return jsonResponse['message'];
      } catch (e) {
        print("Error updating $e");
      }
    } else {
      return jsonResponse['message'];
    }
  }

  Future<dynamic> autoLogin() async {
    final storage = await SharedPreferences.getInstance();
    if (storage.containsKey("userInfo")) {
      print("User Found");
      final localUserInfo = jsonDecode("${storage.getString("userInfo")}");
      _loggedInUser = User(
        id: localUserInfo['id'],
        firstName: localUserInfo['firstName'],
        lastName: localUserInfo['lastName'],
        email: localUserInfo['email'],
        bio: localUserInfo['bio'],
        profileImage: localUserInfo['profileImage'],
        city: localUserInfo['city'],
        phoneNumber: localUserInfo['phoneNumber'],
        accountType: localUserInfo['accountType'],
        majors: localUserInfo['majors'],
        createdAt: localUserInfo['createdAt'],
      );
      print("logged in");
      return _loggedInUser;
    } else {
      print("not logged in");
      return;
    }
  }

  void logout() async {
    final storage = await SharedPreferences.getInstance();
    storage.clear();
    _loggedInUser = null;
    notifyListeners();
  }

  bool isUserInfoChanged(
      String enteredFirstName,
      String enteredLastName,
      String enteredBio,
      String enteredPhoneNumber,
      String enteredCity,
      List<dynamic> enteredMajors) {
    if (loggedInUser != null) {
      if (enteredFirstName == loggedInUser!.firstName &&
          enteredLastName == loggedInUser!.lastName &&
          enteredBio == loggedInUser!.bio &&
          enteredPhoneNumber == loggedInUser!.phoneNumber &&
          enteredCity == loggedInUser!.city &&
          (enteredMajors == loggedInUser!.majors ||
              loggedInUser!.accountType == "project" &&
                  enteredMajors[0] == loggedInUser!.majors[0])) {
                    print("$enteredFirstName - ${loggedInUser!.firstName}");
                    print("$enteredLastName - ${loggedInUser!.lastName}");
                    print("$enteredBio - ${loggedInUser!.bio}");
                    print("$enteredPhoneNumber - ${loggedInUser!.phoneNumber}");
                    print("$enteredCity - ${loggedInUser!.city}");
                    print("$enteredMajors - ${loggedInUser!.majors}");
        return false;
      } else {
        return true;
      }
    }
    return false;
  }
}
