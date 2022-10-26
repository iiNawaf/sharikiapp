import 'package:sharikiapp/providers/auth_provider.dart';
import 'package:sharikiapp/providers/post_provider.dart';

class User {
  String id;
  String firstName;
  String lastName;
  String email;
  String bio;
  String profileImage;
  String city;
  String phoneNumber;
  String accountType;
  dynamic createdAt;
  String? accountStatus;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.bio,
      required this.profileImage,
      required this.city,
      required this.phoneNumber,
      required this.accountType,
      required this.createdAt,
      this.accountStatus});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['_id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        bio: json['bio'],
        profileImage: json['profileImage'],
        city: json['city'],
        phoneNumber: json['phoneNumber'],
        accountType: json['accountType'],
        createdAt: json['createdAt'],
        accountStatus: json['accountStatus']);
  }
}
