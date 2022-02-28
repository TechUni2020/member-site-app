import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String name;
  String profilePicture;
  String coverPicture;
  String bio;
  String knownAs;
  String? twitterId;
  String? githubId;
  String? instagramId;
  String uid;

  UserModel(
      {this.id,
      required this.name,
      required this.profilePicture,
      required this.coverPicture,
      required this.bio,
      required this.knownAs,
      this.twitterId,
      this.githubId,
      this.instagramId,
      required this.uid});

  factory UserModel.fromDoc(DocumentSnapshot doc) {
    return UserModel(
      id: doc.id,
      name: doc['name'],
      profilePicture: doc['profilePicture'],
      coverPicture: doc['coverPicture'],
      bio: doc['bio'],
      knownAs: doc['knownAs'],
      twitterId: doc['twitterId'],
      githubId: doc['githubId'],
      instagramId: doc['instagramId'],
      uid: doc['uid'],
    );
  }
}
