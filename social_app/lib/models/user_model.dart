import 'package:firebase_auth/firebase_auth.dart';

class UserModel{
  late String name;
  late String email;
  late String phone;
  late String uid;
  late String image;
  late String cover;
  late String bio;
  late bool isEmailVerified;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uid,
    required this.image,
    required this.cover,
    required this.bio,
    required this.isEmailVerified,
  });

  UserModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uid = json['uid'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name' : name,
      'email' : email,
      'phone' : phone,
      'uid' : uid,
      'image': image,
      'cover' : cover,
      'bio' : bio,
      'isEmailVerified' : isEmailVerified,
    };
  }

}