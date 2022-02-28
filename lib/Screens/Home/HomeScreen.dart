import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techuni/Constants/Constants.dart';
import 'package:techuni/Models/UserModel.dart';
import 'package:techuni/Services/AuthServices.dart';
import 'package:techuni/Services/DatabaseServices.dart';
import 'package:techuni/Widgets/Home/UserIcon.dart';

class HomeScreen extends StatefulWidget {
  final String currentUserId;

  const HomeScreen({Key? key, required this.currentUserId}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<QuerySnapshot>? _users;

  @override
  void initState() {
    _users = DatabaseServices.getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () async {
            await AuthService().logout();
          },
          child: Text('ログアウト')),
    );
  }
}
