import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String avatarUrl;
  String belongs;
  String discription;
  String github;
  String uid;
  String instagram;
  String name;
  String role;
  String twitter;

  UserModel(
      {this.id,
      this.avatarUrl,
      this.belongs,
      this.discription,
      this.github,
      this.uid,
      this.instagram,
      this.name,
      this.role,
      this.twitter,
      });

  factory UserModel.fromDoc(DocumentSnapshot doc) {
    return UserModel(
      id: doc.id,
      avatarUrl: doc['avatarUrl'],
      belongs: doc['belongs'],
      discription: doc['discription'],
      github: doc['github'],
      uid: doc['id'],
      instagram: doc['instagram'],
      name: doc['name'],
      role: doc['role'],
      twitter: doc['twitter'],
    );
  }
}
