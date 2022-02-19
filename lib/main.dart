import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:techuni/Constants/Constants.dart';
import 'package:techuni/Screens/FeedScreen.dart';
import 'package:provider/provider.dart';
import 'package:techuni/Screens/Welcome/WelcomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: getScreenId(),
      theme: ThemeData(
        brightness: Brightness.light,
      ),
    );
  }

  Widget getScreenId() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return FeedScreen(currentUserId: currentUserId, page: 0);
          } else {
            return WelcomeScreen();
          }
        });
  }
}
