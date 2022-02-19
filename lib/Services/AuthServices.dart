import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:techuni/Constants/Constants.dart';
import 'package:techuni/Models/UserModel.dart';

class AuthService extends ChangeNotifier {
  User? _user;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ignore: non_constant_identifier_names
  AuthModel() {
    final User? _currentUser = _auth.currentUser;

    if (_currentUser != null) {
      _user = _currentUser;
      notifyListeners();
    }
  }

  User? get user => _user;
  bool get loggedIn => _user != null;

  Future<String> signInAnonymous() async {
    print('aaaa');
    var error = '';
    if (FirebaseAuth.instance.currentUser == null) {
      try {
        await FirebaseAuth.instance.signInAnonymously().then((task) async => {
              print('uid: ${task.user!.uid}'),
            });
      } on FirebaseAuthException catch (e) {
        print(e.toString());
        error = e.toString();
      }
    }
    print('current User : ${_auth.currentUser!.uid}');
    notifyListeners();
    return error;
  }

  // ユーザーデータ -----
  Future<void> createUserData(String id, UserModel user) async {
    final data = <String, dynamic>{
      'name': user.name,
      'profilePicture': user.profilePicture,
      'bio': user.bio,
      'twitterId': user.twitterId,
      'githubId': user.githubId,
      'instagramId': user.instagramId,
      'uid': id.substring(1, 11)
    };

    await usersRef
        .doc(id)
        .set(
          data,
        )
        .catchError(
          (Object error) => print('Failed to set data: ${error.toString()}'),
        );
  }

  bool isAnonymousLogin() {
    return _auth.currentUser!.isAnonymous;
  }

  // Future signUp(String name, String email, String password) async {
  //   try {
  //     UserCredential result = await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);

  //     _user = result.user;

  //     if (_user != null) {
  //       _fireStore.collection('users').doc(_user!.uid).set({
  //         'name': name,
  //         'email': email,
  //         'profilePicture': '',
  //         'coverImage': '',
  //         'bio': '',
  //         'official': false,
  //         'uid': _user!.uid.substring(1, 11)
  //       });
  //       notifyListeners();
  //       return FirebaseAuthResultStatus.Successful;
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     return FirebaseAuthExceptionHandler.handleException(e);
  //   }
  // }

  // Future<void> registration(String email, String pass) async {
  //   try {
  //     final authCredential =
  //         EmailAuthProvider.credential(email: email, password: pass);

  //     final userCredential = await FirebaseAuth.instance.currentUser!
  //         .linkWithCredential(authCredential);

  //     print(userCredential.user!.uid);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //     }
  //   } on Exception catch (e) {
  //     print(e);
  //   }
  // }

  // Future login(String email, String password) async {
  //   try {
  //     UserCredential result = await _auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     _user = result.user;
  //     notifyListeners();
  //     return FirebaseAuthResultStatus.Successful;
  //   } on FirebaseAuthException catch (e) {
  //     notifyListeners();
  //     return FirebaseAuthExceptionHandler.handleException(e);
  //   }
  // }

  Future<void> logout() async {
    _user = null;
    try {
      await _auth.signOut();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
