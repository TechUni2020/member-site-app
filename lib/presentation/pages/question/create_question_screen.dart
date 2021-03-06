import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:techuni/presentation/widgets/profile/submit_bar.dart';


class CreateQuestionScreen extends StatefulWidget {
  final String currentUserId;

  const CreateQuestionScreen({Key? key, required this.currentUserId})
      : super(key: key);

  @override
  _CreateQuestionScreenState createState() => _CreateQuestionScreenState();
}

class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _title = TextEditingController();
  TextEditingController _comment = TextEditingController();
  TextEditingController _technology = TextEditingController();
  TextEditingController _environment = TextEditingController();
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
    // _globalkey.currentState!.save();
    // if (_globalkey.currentState!.validate() && !_isSubmitting) {
    //   setState(() {
    //     _isSubmitting = true;
    //   });
    //   // String profilePictureUrl = '';
    //   // // ignore: unnecessary_null_comparison
    //   // if (_profilePicture == null) {
    //   //   profilePictureUrl = '';
    //   // } else {
    //   //   profilePictureUrl =
    //   //       await StorageService.uploadProfilePicture('', _profilePicture!);
    //   // }
    //   QuestionModel question = QuestionModel(
    //     title: _title.text,
    //     comment: _comment.text,
    //     technology: _technology.text,
    //     environment: _environment.text,
    //   );
    //   await DatabaseServices().createQuestionData(question);
    //   _isSubmitting = false;
    //   Navigator.pop(context);
    // }
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
            // imageProfile(),
            // SizedBox(
            //   height: 20,
            // ),
            titleTextField(),
            SizedBox(
              height: 20,
            ),
            technologyTextField(),
            SizedBox(
              height: 20,
            ),
            environmentTextField(),
            SizedBox(
              height: 20,
            ),
            commentTextField(),
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

  // Widget imageProfile() {
  //   return Center(
  //       child: GestureDetector(
  //           onTap: () {
  //             // Navigator.push(
  //             //   context,
  //             //   CupertinoPageRoute(
  //             //     builder: (context) =>
  //             //         ImagePreview(image: widget.tweet.image!),
  //             //   ),
  //             // );
  //           },
  //           child: Container(
  //             height: 200,
  //             decoration: BoxDecoration(
  //                 color: Palette.white,
  //                 borderRadius: BorderRadius.circular(10),
  //                 image: DecorationImage(
  //                   fit: BoxFit.cover,
  //                   image: displayProfileImage(),
  //                 )),
  //           )));
  // }

  Widget titleTextField() {
    return TextFormField(
      controller: _title,
      validator: (value) {
        if (value!.isEmpty) return "????????????";
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
        labelText: "????????????",
        helperText: "???????????????????????????????????????",
        hintText: "Flutter webview????????????",
      ),
    );
  }

  Widget technologyTextField() {
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
        labelText: "????????????",
        helperText: "????????????????????????",
        hintText: "Flutter, Firebase",
      ),
    );
  }

  Widget environmentTextField() {
    return TextFormField(
      controller: _environment,
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
        labelText: "????????????",
        helperText: "????????????????????????",
        hintText: "Flutter -v: >=2.12.0 <3.0.0",
      ),
    );
  }

  Widget commentTextField() {
    return TextFormField(
      controller: _comment,
      validator: (value) {
        if (value!.isEmpty) return "???????????????????????????????????????";

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
        labelText: "????????????",
        helperText: "????????????????????????",
        hintText: "Flutter run??????cocoapod?????????????????????",
      ),
    );
  }
}
