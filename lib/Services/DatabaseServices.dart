import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techuni/Constants/Constants.dart';
import 'package:techuni/Models/UserModel.dart';

class DatabaseServices {

  static void updateUserData(UserModel user) {
    usersRef.doc(user.id).update({
      'name': user.name,
      'bio': user.discription,
      'profilePicture': user.avatarUrl,
      'uid': user.uid,
    });
  }

  static Future<QuerySnapshot> searchUsers(String uid) async {
    Future<QuerySnapshot> users = usersRef
        .where('uid', isGreaterThanOrEqualTo: uid)
        .where('uid', isLessThan: uid + 'z')
        .get();
    return users;
  }

  static Future<List<UserModel>> getAllUsers() async {
    QuerySnapshot allUserDoc =
        await usersRef.get();

    List<UserModel> allUsers =
        allUserDoc.docs.map((doc) => UserModel.fromDoc(doc)).toList();

    return allUsers;
  }

  static Future<List<UserModel>> getManagementUsers() async {
    QuerySnapshot managementUserDoc =
        await usersRef.where('manage',isEqualTo: true).get();

    List<UserModel> managementUsers =
        managementUserDoc.docs.map((doc) => UserModel.fromDoc(doc)).toList();

    return managementUsers;
  }
}
