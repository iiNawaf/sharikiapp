class Post {
  String id;
  String publisherID;
  String publisherPhoneNumber;
  String title;
  String city;
  String description;
  String requiredJob;
  String postType;
  dynamic time;

  Post(
      {required this.id,
      required this.publisherID,
      required this.publisherPhoneNumber,
      required this.title,
      required this.city,
      required this.description,
      required this.requiredJob,
      required this.postType,
      required this.time});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['_id'],
        publisherID: json['publisherID'],
        publisherPhoneNumber: json['publisherPhoneNumber'],
        title: json['title'],
        city: json['city'],
        description: json['description'],
        requiredJob: json['requiredJob'],
        postType: json['postType'],
        time: json['time']);
  }
}
