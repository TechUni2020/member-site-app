import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String profilePicture;
  String bio;
  String twitterId;
  String githubId;
  String instagramId;
  String uid;

  UserModel(
      {required this.id,
      required this.name,
      required this.profilePicture,
      required this.bio,
      required this.twitterId,
      required this.githubId,
      required this.instagramId,
      required this.uid});

  factory UserModel.fromDoc(DocumentSnapshot doc) {
    return UserModel(
      id: doc.id,
      name: doc['name'],
      profilePicture: doc['profilePicture'],
      bio: doc['bio'],
      twitterId: doc['twitterId'],
      githubId: doc['githubId'],
      instagramId: doc['instagramId'],
      uid: doc['uid'],
    );
  }
}
