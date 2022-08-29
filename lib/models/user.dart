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
}
