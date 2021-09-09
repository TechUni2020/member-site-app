import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthModel extends ChangeNotifier {
  User _user;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthModel() {
    final User _currentUser = _auth.currentUser;

    if (_currentUser != null) {
      _user = _currentUser;
      notifyListeners();
    }
  }

  User get user => _user;
  bool get loggedIn => _user != null;


  //エラーハンドリング付け足す
  Future<bool> login(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _user = result.user;
      notifyListeners();
      return true;
    } catch (error) {
      print(error.toString());
      return false;
    }
  }

  Future<bool> signup(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _user = result.user;
      notifyListeners();
      return true;
    } catch (error) {
      print(error.toString());
      return false;
    }
  }

  Future<void> logout() async {
    _user = null;
    await _auth.signOut();
    notifyListeners();
  }
}
