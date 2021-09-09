import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:techuni/root.dart';
import 'package:techuni/screens/auth/auth.dart';
import 'package:provider/provider.dart';

import 'models/auth_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:  _LoginCheck(),
    );
  }
}

class _LoginCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ログイン状態に応じて、画面を切り替える
    //AuthModelで一括管理
    final bool _loggedIn = context.watch<AuthModel>().loggedIn;
    return _loggedIn
        ? RootWidget()
        : AuthScreen();
  }
}