import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:techuni/common/constants/constants.dart';
import 'package:techuni/domain/auth/auth_repository.dart';
import 'package:techuni/domain/firebase_storage/firebase_storage_repository.dart';
import 'package:techuni/domain/user/models/user.dart';
import 'package:techuni/presentation/widgets/profile/submit_bar.dart';

class CreateProductScreen extends StatefulWidget {
  final String currentUserId;

  const CreateProductScreen({Key? key, required this.currentUserId})
      : super(key: key);

  @override
  _CreateProductScreenState createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _title = TextEditingController();
  TextEditingController _about = TextEditingController();
  TextEditingController _technology = TextEditingController();
  TextEditingController _period = TextEditingController();
  TextEditingController _instagramId = TextEditingController();
  XFile? _profilePicture;
  late bool _isSubmitting;

  displayProfileImage() {
    // ignore: unnecessary_null_comparison
    if (_profilePicture == null) {
      return AssetImage('assets/images/placeholder.png');
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
        name: _title.text,
        profilePicture: profilePictureUrl,
        coverPicture: profilePictureUrl,
        bio: _about.text,
        knownAs: '',
        uid: '',
        twitterId: _technology.text,
        githubId: _period.text,
        instagramId: _instagramId.text,
      );
      await AuthService().createUserData(currentUserId, user);
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
        title: Text('???????????????'),
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
                  '???????????????????????????\n??????',
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
      controller: _title,
      validator: (value) {
        if (value!.isEmpty) return "????????????????????????????????????";
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
        helperText: "?????????????????????????????????",
        hintText: "Tech.Uni",
      ),
    );
  }

  Widget twitterTextField() {
    return TextFormField(
      controller: _technology,
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
        helperText: "Twitter?????????????????????????????????",
        hintText: "TechUni1026",
      ),
    );
  }

  Widget githubField() {
    return TextFormField(
      controller: _period,
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
        helperText: "Github?????????????????????????????????",
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
        helperText: "Instagram?????????????????????????????????",
        hintText: "tech_uni1026",
      ),
    );
  }

  Widget bioTextField() {
    return TextFormField(
      controller: _about,
      validator: (value) {
        if (value!.isEmpty) return "??????????????????????????????????????????";

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
        helperText: "??????????????????????????????????????????",
        hintText: "??????????????????????????????Tech.Uni??????",
      ),
    );
  }
}
