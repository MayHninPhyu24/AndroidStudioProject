import 'package:firebase_auth/firebase_auth.dart';

class PostModel{
  late String name;
  late String uid;
  late String image;
  late String dateTime;
  late String text;
  String? postImage;

  PostModel({
    required this.name,
    required this.uid,
    required this.image,
    required this.dateTime,
    required this.text,
    this.postImage,
  });

  PostModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    uid = json['uid'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name' : name,
      'uid' : uid,
      'image': image,
      'dateTime' : dateTime,
      'text' : text,
      'postImage' : postImage,
    };
  }
}