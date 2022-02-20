import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:techuni/Models/UserModel.dart';
import 'package:techuni/Services/DatabaseServices.dart';

class MembersProvider extends ChangeNotifier {
  // final _tweetsSnapshot = <DocumentSnapshot>[];
  final _membersSnapshot = <DocumentSnapshot>[];
  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  List<UserModel> get members =>
      _membersSnapshot.map((snap) => UserModel.fromDoc(snap)).toList();

  Future getAllMambers() async {
    try {
      QuerySnapshot snap = await DatabaseServices.getAllUsers();
      _membersSnapshot.addAll(snap.docs);
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
    }
  }
}
