import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:techuni/domain/auth/auth_repository.dart';



class HomeScreen extends StatefulWidget {
  final String currentUserId;

  const HomeScreen({Key? key, required this.currentUserId}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState() {
    // _users = DatabaseServices.getAllUsers();
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
