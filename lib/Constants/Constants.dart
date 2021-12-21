import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class Palette {
  static const utilColor = {
   "white": const Color(0xffffffff),
   "grey": const Color.fromRGBO(115,115,115,1),
   "lightblue": const Color.fromRGBO(200,228,224,1),
  };
}

final _fireStore = FirebaseFirestore.instance;
final _fireAuth = FirebaseAuth.instance;

final usersRef = _fireStore.collection('user');

final storageRef = FirebaseStorage.instance.ref();

final currentUserId = _fireAuth.currentUser.uid.toString();

final currentUser = _fireAuth.currentUser;
