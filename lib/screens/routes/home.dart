import 'package:flutter/material.dart';
import 'package:techuni/models/auth_model.dart';
import 'package:techuni/screens/auth/auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBarMain(context),
      // drawer: drawerMain(context),
      body: Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 40.0),
          Container(
            height: 300,
          ),
          Container(
            child: Text(
              "Hello",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          RaisedButton(
            padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
            onPressed: () {
              AuthModel().logout().then((value) =>
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AuthScreen()),
                  (_) => false));
            },
            child: Text('Signout',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold)),
            color: Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          )
        ],
      ),
    ));
  }
}
