import 'package:cloud_firestore/cloud_firestore.dart';

class ClubModel {
  String? clubId;
  String? title;
  String? category;
  String? createdBy;
  List? speakers;
  Timestamp? dateTime;
  String? type;
  String? status;

  ClubModel({
    this.clubId,
    this.title,
    this.category,
    this.createdBy,
    this.speakers,
    this.dateTime,
    this.type,
    this.status
  });

  factory ClubModel.fromMap(QueryDocumentSnapshot documentSnapshot) {
    return ClubModel(
      clubId: documentSnapshot.id,
      title: documentSnapshot['title'],
      category: documentSnapshot['category'],
      createdBy: documentSnapshot['createdBy'],
      speakers: documentSnapshot['invited'],
      dateTime: documentSnapshot['dateTime'],
      type: documentSnapshot['type'],
      status: documentSnapshot['status'],
    );
  }

}