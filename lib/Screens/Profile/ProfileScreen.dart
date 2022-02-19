import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:techuni/Constants/Constants.dart';
import 'package:techuni/Models/UserModel.dart';

class ProfileScreen extends StatefulWidget {
  final String currentUserId;
  final String visitedUserId;

  const ProfileScreen(
      {Key? key, required this.currentUserId, required this.visitedUserId})
      : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final double coverHeight = 280;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: usersRef.doc(widget.visitedUserId).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Palette.yellow),
              ),
            );
          }
          UserModel userModel = UserModel.fromDoc(snapshot.data);

          return Scaffold(
              body: ListView(padding: EdgeInsets.zero, children: <Widget>[
            buildTop(userModel),
            buildContent(userModel),
          ]));
        });
  }

  Widget buildTop(UserModel user) {
    final bottom = profileHeight / 2;
    final top = coverHeight - profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
            margin: EdgeInsets.only(bottom: bottom),
            child: buildCoverImage(user)),
        Positioned(top: top, child: buildProfileImage(user)),
      ],
    );
  }

  Widget buildContent(UserModel user) => Column(
        children: [
          const SizedBox(),
          Text(
            user.name,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Frontend Engineer',
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSocialIcon(FontAwesomeIcons.github),
              const SizedBox(
                width: 12,
              ),
              buildSocialIcon(FontAwesomeIcons.twitter),
              const SizedBox(
                width: 12,
              ),
              buildSocialIcon(FontAwesomeIcons.instagram),
              const SizedBox(
                width: 12,
              ),
            ],
          ),
          Divider(),
          const SizedBox(height: 16),
          buildBio(user),
        ],
      );

  Widget buildSocialIcon(IconData icon) => CircleAvatar(
        radius: 25,
        child: Material(
          shape: CircleBorder(),
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Center(
                child: Icon(
              icon,
              size: 32,
            )),
          ),
        ),
      );

  Widget buildBio(UserModel user) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '自己紹介',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Text(user.bio)
          ],
        ),
      );

  Widget buildCoverImage(UserModel user) => Container(
        color: Colors.grey,
        width: double.infinity,
        height: coverHeight,
      );

  Widget buildProfileImage(UserModel user) => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: user.profilePicture.isEmpty
            ? AssetImage('assets/placeholder.png')
            : NetworkImage(user.profilePicture) as ImageProvider,
      );
}
