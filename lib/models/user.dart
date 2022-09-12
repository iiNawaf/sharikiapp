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
      required this.createdAt});

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
        createdAt: json['createdAt']);
  }

  static List<String> userImage(AuthProvider ap, PostProvider pp){
    List<String> imgsUrl = [];
    for(int i = 0; i < ap.usersList!.length; i++){
      for(int j = 0; j < pp.posts.length; j++){
        if(ap.usersList![i].id == pp.posts[j].publisherID){
          imgsUrl.add(ap.usersList![j].profileImage);
        }
      }
    }
    return imgsUrl;
  }
}
