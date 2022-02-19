import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techuni/Screens/Welcome/StartProfileScreen.dart';
import 'package:techuni/Services/AuthServices.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/welcome_background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await AuthService().signInAnonymous();
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => StartProfileScreen(),
                      ));
                },
                child: Text(
                  "はじめる",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
