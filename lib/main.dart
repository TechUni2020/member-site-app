import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:techuni/route.dart';
import 'package:techuni/screens/auth/signin.dart';
import 'package:techuni/screens/routes/root.dart';
import 'package:provider/provider.dart';

import 'models/auth_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        routes: AppRoutes.define(),
        // home: _LoginCheck(),
        home: RootWidget(),
      )
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
        : SignIn();
  }
}