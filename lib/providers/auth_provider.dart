import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharikiapp/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:sharikiapp/providers/connection_provider.dart';

class AuthProvider with ChangeNotifier {
  ConnectionProvider connectionProvider;
  AuthProvider({required this.connectionProvider});
  User? _loggedInUser;
  List<User>? _usersList = [];
  User? get loggedInUser => _loggedInUser;
  List<User>? get usersList => _usersList;
  bool isLoading = false;

  Future<dynamic> login(String email, String password) async {
    final url =
        Uri.parse(connectionProvider.connection.baseUrl + "api/auth/login");
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
            createdAt: jsonResponse['user']['createdAt'],
            accountStatus: jsonResponse['user']['accountStatus']);

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
          'createdAt': jsonResponse['user']['createdAt'],
          'accountStatus': jsonResponse['user']['accountStatus']
        });

        final storage = await SharedPreferences.getInstance();
        await storage.setString("userInfo", loggedInUserInfo);
        await storage.setString("token", jsonResponse['token']);
        notifyListeners();
        print(jsonResponse['token']);

        return "";
      } catch (e) {
        print("Error occurred: $e");
      }
    } else {
      return jsonResponse['message'];
    }
    return "";
  }

  Future<dynamic> signUp(
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      String password,
      String accountType,
      String city) async {
    final url =
        Uri.parse(connectionProvider.connection.baseUrl + "api/auth/signup");
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
        // 'profileImage': "", default image already in server
        'phoneNumber': phoneNumber,
        'password': password,
        'accountType': accountType,
        'city': city,
      }),
    );

    final jsonResponse = jsonDecode(response.body);
    print(jsonResponse);

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
            createdAt: jsonResponse['user']['createdAt'],
            accountStatus: jsonResponse['user']['accountStatus']);

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
          'createdAt': jsonResponse['user']['createdAt'],
          'accountStatus': jsonResponse['user']['accountStatus'],
        });

        final storage = await SharedPreferences.getInstance();
        storage.setString("userInfo", createdUserInfo);
        await storage.setString("token", jsonResponse['token']);
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

  Future upload(File imageFile) async {
    final storage = await SharedPreferences.getInstance();
    if (storage.containsKey("token")) {
      // open a bytestream
      var stream =
          new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      // get file length
      var length = await imageFile.length();
      // string to uri
      var uri = Uri.parse(connectionProvider.connection.baseUrl +
          "api/auth/updateuserinfo/${_loggedInUser!.id}");
      // create multipart request
      var request = new http.MultipartRequest("PUT", uri);
      request.headers
          .addAll({"Authorization": "Bearer ${storage.getString("token")!}"});
      // multipart that takes file
      var multipartFile = new http.MultipartFile('profileImage', stream, length,
          filename: basename(imageFile.path.split('.').last));
      // add file to multipart
      request.files.add(multipartFile);

      // send
      final response = await request.send();
      final respStr = await response.stream.bytesToString();
      final jsonResponse = await jsonDecode(respStr);
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
            createdAt: jsonResponse['updatedUser']['createdAt'],
            // accountStatus: jsonResponse['user']['accountStatus']
          );

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
            'createdAt': jsonResponse['updatedUser']['createdAt'],
            // 'accountStatus': jsonResponse['user']['accountStatus'],
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
      }
    }
  }

  Future<void> fetchUserInfo() async {
    final storage = await SharedPreferences.getInstance();
    isLoading = true;
    if (storage.containsKey("token")) {
      final url = Uri.parse(connectionProvider.connection.baseUrl +
          "api/auth/fetchuserlist/${_loggedInUser!.accountType}");
      final response = await http.get(url,
          headers: {"Authorization": "Bearer ${storage.getString("token")!}"});

      if (response.statusCode == 201) {
        final jsonResponse =
            jsonDecode(response.body)['users'].cast<Map<String, dynamic>>();
        _usersList =
            jsonResponse.map<User>((json) => User.fromJson(json)).toList();
      } else {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse['message'];
      }
      isLoading = false;
    } else {
      isLoading = false;
    }
  }

  Future<dynamic> updateUserProfileInfo(String firstName, String lastName,
      String bio, String phoneNumber, String city) async {
    if (isUserInfoChanged(firstName, lastName, bio, phoneNumber, city) ==
        false) {
      return "لم تجري أي تغييرات";
    }
    final storage = await SharedPreferences.getInstance();
    if (storage.containsKey("token")) {
      final url = Uri.parse(connectionProvider.connection.baseUrl +
          "api/auth/updateuserinfo/${_loggedInUser!.id}");
      final response = await http.put(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": "Bearer ${storage.getString("token")!}"
          },
          body: jsonEncode(<String, dynamic>{
            'firstName': firstName,
            'lastName': lastName,
            'bio': bio,
            'phoneNumber': phoneNumber,
            'city': city,
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
              createdAt: jsonResponse['updatedUser']['createdAt'],
              accountStatus: jsonResponse['user']['accountStatus']);

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
            'createdAt': jsonResponse['updatedUser']['createdAt'],
            'accountStatus': jsonResponse['user']['accountStatus']
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
    } else {
      return false;
    }
  }

  Future<dynamic> forgotPassword(String email) async {
    final url = Uri.parse(
        connectionProvider.connection.baseUrl + "api/auth/forgotpassword");
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'email': email}));

    final jsonResponse = jsonDecode(response.body);

    try {
      if (response.statusCode == 201) {
        return "";
      } else if (response.statusCode == 400) {
        return jsonResponse['message'];
      } else if (response.statusCode == 401) {
        return jsonResponse['message'];
      }
    } catch (e) {
      return "حصل خطأ";
    }
  }

  Future<dynamic> autoLogin() async {
    final storage = await SharedPreferences.getInstance();
    if (storage.containsKey("userInfo") && storage.containsKey("token")) {
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
          createdAt: localUserInfo['createdAt'],
          accountStatus: localUserInfo['accountStatus']);
      print("logged in");
      return _loggedInUser;
    } else {
      print("not logged in");
      return null;
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
  ) {
    if (loggedInUser != null) {
      if (enteredFirstName == loggedInUser!.firstName &&
          enteredLastName == loggedInUser!.lastName &&
          enteredBio == loggedInUser!.bio &&
          enteredPhoneNumber == loggedInUser!.phoneNumber &&
          enteredCity == loggedInUser!.city) {
        return false;
      } else {
        return true;
      }
    }
    return false;
  }

  Future<dynamic> disableAccount() async {
    final storage = await SharedPreferences.getInstance();
    print(storage.containsKey("token"));
    if (storage.containsKey("token")) {
      final url = Uri.parse(connectionProvider.connection.baseUrl +
          "api/auth/disableuser/${_loggedInUser!.id}");
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer ${storage.getString("token")!}"
        },
      );
      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return "";
      } else {
        return jsonResponse['message'];
      }
    }
    return "";
  }
}
