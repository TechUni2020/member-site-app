import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:techuni/Constants/Constants.dart';
import 'package:techuni/Models/UserModel.dart';
import 'package:techuni/Services/DatabaseServices.dart';
import 'package:techuni/Services/StorageService.dart';
import 'package:techuni/Widgets/Profile/submit_bar.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;

  const EditProfileScreen({Key? key, required this.user}) : super(key: key);
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _bio = TextEditingController();
  TextEditingController _knownAs = TextEditingController();
  TextEditingController _twitterId = TextEditingController();
  TextEditingController _githubId = TextEditingController();
  TextEditingController _instagramId = TextEditingController();
  XFile? _profilePicture;
  late bool _isSubmitting;

  displayProfileImage() {
    // ignore: unnecessary_null_comparison
    if (_profilePicture == null) {
      if (widget.user.profilePicture.isEmpty) {
        return AssetImage('assets/images/placeholder.png');
      } else {
        return NetworkImage(widget.user.profilePicture);
      }
    } else {
      return FileImage(File(_profilePicture!.path));
    }
  }

  handleImageFromGallery() async {
    try {
      XFile imageFile = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 85) as XFile;
      setState(() {
        _profilePicture = imageFile;
      });
    } catch (e) {
      print(e);
    }
  }

  _submit() async {
    _globalkey.currentState!.save();
    if (_globalkey.currentState!.validate() && !_isSubmitting) {
      setState(() {
        _isSubmitting = true;
      });
      String profilePictureUrl = '';
      // ignore: unnecessary_null_comparison
      if (_profilePicture == null) {
        profilePictureUrl = '';
      } else {
        profilePictureUrl =
            await StorageService.uploadProfilePicture('', _profilePicture!);
      }
      UserModel user = UserModel(
        name: _name.text,
        profilePicture: profilePictureUrl,
        coverPicture: '',
        bio: _bio.text,
        knownAs: _knownAs.text,
        uid: '',
        twitterId: _twitterId.text,
        githubId: _githubId.text,
        instagramId: _instagramId.text,
      );
      print(currentUserId);
      await DatabaseServices.updateUserData(user);
      _isSubmitting = false;
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    _name.text = widget.user.name;
    _bio.text = widget.user.bio;
    _knownAs.text = widget.user.knownAs;
    _twitterId.text = widget.user.twitterId!;
    _instagramId.text = widget.user.instagramId!;
    _githubId.text = widget.user.githubId!;
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
            imageProfile(),
            SizedBox(
              height: 20,
            ),
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

  Widget imageProfile() {
    return Center(
        child: GestureDetector(
      onTap: () {
        handleImageFromGallery();
      },
      child: Stack(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundImage: displayProfileImage(),
          ),
          CircleAvatar(
            radius: 45,
            backgroundColor: Colors.black54,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.camera_alt,
                  size: 30,
                  color: Colors.white,
                ),
                Text(
                  'プロフィール画像を\n編集',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
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
