class Post{
  String id;
  String publisherID;
  String publisherPhoneNumber;
  String title;
  String requestedMajor;
  String city;
  String description;
  dynamic time;

  Post({required this.id, required this.publisherID, required this.publisherPhoneNumber, required this.title, required this.requestedMajor, required this.city, required this.description, required this.time});

  factory Post.fromJson(Map<String, dynamic> json){
    return Post(
      id: json['_id'],
      publisherID: json['publisherID'],
      publisherPhoneNumber: json['publisherPhoneNumber'],
      title: json['title'],
      requestedMajor: json['requestedMajor'],
      city: json['city'],
      description: json['description'],
      time: json['time']
    );
  }
}