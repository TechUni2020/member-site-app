import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:techuni/Models/FirebaseError.dart';
import 'package:techuni/Utils/Auth/FirebaseError.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      notifyListeners();
      return FirebaseAuthResultStatus.Successful;
    } catch (e) {
      notifyListeners();
      return FirebaseAuthExceptionHandler.handleException(e);
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
