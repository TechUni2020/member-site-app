import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:techuni/presentation/pages/feed_screen.dart';
import 'package:provider/provider.dart';
import 'package:techuni/presentation/pages/welcome/welcome_screen.dart';

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
            return FeedScreen();
          } else {
            return WelcomeScreen();
          }
        });
  }
}
