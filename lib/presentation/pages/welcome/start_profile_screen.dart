import 'dart:io';

import 'package:flutter/material.dart';
import 'package:techuni/common/constants/constants.dart';
import 'package:techuni/domain/auth/auth_repository.dart';
import 'package:techuni/domain/user/models/user.dart';
import 'package:techuni/presentation/widgets/profile/submit_bar.dart';


class StartProfileScreen extends StatefulWidget {
  final onSignInPressed;
  const StartProfileScreen({Key? key, this.onSignInPressed}) : super(key: key);

  @override
  _StartProfileScreenState createState() => _StartProfileScreenState();
}

class _StartProfileScreenState extends State<StartProfileScreen> {
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _bio = TextEditingController();
  TextEditingController _knownAs = TextEditingController();
  TextEditingController _twitterId = TextEditingController();
  TextEditingController _githubId = TextEditingController();
  TextEditingController _instagramId = TextEditingController();
  late bool _isSubmitting;

  _submit() async {
    _globalkey.currentState!.save();
    if (_globalkey.currentState!.validate() && !_isSubmitting) {
      setState(() {
        _isSubmitting = true;
      });
      UserModel user = UserModel(
        name: _name.text,
        profilePicture: '',
        coverPicture: '',
        bio: _bio.text,
        knownAs: _knownAs.text,
        uid: '',
        twitterId: _twitterId.text,
        githubId: _githubId.text,
        instagramId: _instagramId.text,
      );
      await AuthService().signInAnonymous(user);
      _isSubmitting = false;
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    _isSubmitting = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'プロフィール',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Palette.white,
      ),
      body: Form(
        key: _globalkey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: <Widget>[
            nameTextField(),
            SizedBox(
              height: 20,
            ),
            twitterTextField(),
            SizedBox(
              height: 20,
            ),
            githubField(),
            SizedBox(
              height: 20,
            ),
            instagramTextField(),
            SizedBox(
              height: 20,
            ),
            knownAsField(),
            SizedBox(
              height: 20,
            ),
            bioTextField(),
            SizedBox(
              height: 20,
            ),
            SubmitBar(
              label: 'Submit',
              onPressed: _submit,
              isLoading: _isSubmitting,
            ),
          ],
        ),
      ),
    );
  }

  Widget nameTextField() {
    return TextFormField(
      controller: _name,
      validator: (value) {
        if (value!.isEmpty) return "名前が入力されていません";
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: "Name",
        helperText: "名前を入力してください",
        hintText: "Tech.Uni",
      ),
    );
  }

  Widget twitterTextField() {
    return TextFormField(
      controller: _twitterId,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: "TwitterId",
        helperText: "Twitterアカウントをお持ちの方",
        hintText: "TechUni1026",
      ),
    );
  }

  Widget githubField() {
    return TextFormField(
      controller: _githubId,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: "githubId",
        helperText: "Githubアカウントをお持ちの方",
        hintText: "TechUni1026",
      ),
    );
  }

  Widget instagramTextField() {
    return TextFormField(
      controller: _instagramId,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: "instagramId",
        helperText: "Instagramアカウントをお持ちの方",
        hintText: "tech_uni1026",
      ),
    );
  }

  Widget knownAsField() {
    return TextFormField(
      controller: _knownAs,
      validator: (value) {
        if (value!.isEmpty) return "自分を表す一言を入力してください";
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        labelText: "knownAs",
        helperText: "自分を表す一言を記入してください",
        hintText: "技術大好き人間",
      ),
    );
  }

  Widget bioTextField() {
    return TextFormField(
      controller: _bio,
      validator: (value) {
        if (value!.isEmpty) return "自己紹介文を記入してください";

        return null;
      },
      maxLines: 4,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        labelText: "Bio",
        helperText: "自己紹介文を記入してください",
        hintText: "プログラミング研究会Tech.Uniです",
      ),
    );
  }
}
