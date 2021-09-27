import 'package:flutter/material.dart';
import 'package:techuni/models/auth_model.dart';
import 'package:techuni/screens/auth/signin.dart';

class editpage extends StatefulWidget {
  @override
  _editpageState createState() => _editpageState();
}

class _editpageState extends State<editpage> {
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
              Container(
                height: 200,
              ),
              Container(
                width: 110.0,
                height: 110.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/IMG_5734.jpg'),
                    )),
              ),
              Text(
                "ユーザーネーム",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                child: const Text('Button'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
          Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      "name",
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Form(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'ユーザーネーム'),
                      ),
                    ),
                    Text(
                      "mail",
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Form(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'メールアドレス'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
