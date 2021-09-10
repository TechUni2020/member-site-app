import 'package:flutter/material.dart';
import 'package:techuni/screens/auth/signin.dart';
import 'package:techuni/screens/routes/root.dart';

class AppRoutes {
  AppRoutes._();

  static const String authLogin = '/auth-login';
  static const String authRegister = '/auth-register';
  static const String home = '/home';
  // static const String mypage = '/mypage';
  // static const String editmypage = '/edit-mypage';

  static Map<String, WidgetBuilder> define() {
    return {
      authLogin: (context) => SignIn(),
      home: (context) => RootWidget(),
      // mypage: (context) => ProfilePage(),
      // editmypage: (context) => EditProfilePage()
    };
  }
}