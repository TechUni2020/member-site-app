import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techuni/Constants/Constants.dart';
import 'package:techuni/Models/UserModel.dart';
import 'package:techuni/Services/DatabaseServices.dart';
import 'package:techuni/Services/StorageService.dart';
import 'package:image_picker/image_picker.dart';


class EditProfileScreen extends StatefulWidget {
  final UserModel user;

  const EditProfileScreen({Key key, this.user}) : super(key: key);
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String _name;
  String _bio;
  String _uid;
  String _message;
  File _profileImage;
  String _imagePickedType;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  displayProfileImage() {
    if (_profileImage == null) {
      if (widget.user.avatarUrl.isEmpty) {
        return AssetImage('assets/placeholder.png');
      } else {
        return NetworkImage(widget.user.avatarUrl);
      }
    } else {
      return FileImage(_profileImage);
    }
  }

  saveProfile() async {
    _formKey.currentState.save();
    if (_formKey.currentState.validate() && !_isLoading) {
      setState(() {
        _isLoading = true;
      });
      String profilePictureUrl = '';
      if (_profileImage == null) {
        profilePictureUrl = widget.user.avatarUrl;
      } else {
        profilePictureUrl = await StorageService.uploadProfilePicture(
            widget.user.avatarUrl, _profileImage);
      }
      UserModel user = UserModel(
          id: widget.user.id,
          name: _name,
          avatarUrl: profilePictureUrl,
          discription: _bio,
          uid: _uid);
      DatabaseServices.updateUserData(user);
      Navigator.pop(context);
    }
  }

  handleImageFromGallery() async {
    try {
      File imageFile = await ImagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 85);
      if (imageFile != null) {
        if (_imagePickedType == 'profile') {
          setState(() {
            _profileImage = imageFile;
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _name = widget.user.name;
    _bio = widget.user.discription;
    _uid = widget.user.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          title: Text('プロフィール編集'),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            Stack(alignment: Alignment.center, children: <Widget>[
              Align(
                  alignment: Alignment.centerRight,
                  child: ButtonTheme(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minWidth: 0,
                    height: 0,
                    child: TextButton(
                      child: Text(
                        "保存",
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      onPressed: () {
                        saveProfile();
                      },
                    ),
                  ))
            ])
          ]),
      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      _imagePickedType = 'profile';
                      handleImageFromGallery();
                    },
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 65,
                          backgroundImage: displayProfileImage(),
                        ),
                        CircleAvatar(
                          radius: 65,
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
                                'プロフィール画像を編集',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        TextFormField(
                          cursorColor: Palette.utilColor["grey"],
                          initialValue: _name,
                          decoration: InputDecoration(
                            labelText: 'ニックネーム',
                            labelStyle: TextStyle(color: Colors.grey),
                          ),
                          validator: (input) =>
                              input.trim().length < 2 ? '2文字以上で入力して下さい' : null,
                          onSaved: (value) {
                            _name = value;
                          },
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          cursorColor: Palette.utilColor["grey"],
                          initialValue: _message,
                          maxLength: 15,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: '今日のひとこと',
                            labelStyle: TextStyle(color: Colors.grey),
                          ),
                          onSaved: (value) {
                            _message = value;
                          },
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          cursorColor: Palette.utilColor["grey"],
                          initialValue: _bio,
                          maxLength: 140,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: '自己紹介',
                            labelStyle: TextStyle(color: Colors.grey),
                          ),
                          onSaved: (value) {
                            _bio = value;
                          },
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          cursorColor: Palette.utilColor["grey"],
                          initialValue: _uid,
                          decoration: InputDecoration(
                            labelText: 'ユーザーID',
                            labelStyle: TextStyle(color: Colors.grey),
                          ),
                          onSaved: (value) {
                            _uid = value;
                          },
                        ),
                        SizedBox(height: 30),
                        _isLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Palette.utilColor["grey"],),
                              )
                            : SizedBox.shrink()
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
