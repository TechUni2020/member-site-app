import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:techuni/common/constants/constants.dart';
import 'package:techuni/domain/user/models/user.dart';
import 'package:techuni/Utils/Utils.dart';
import 'package:techuni/presentation/pages/profile/edit_profile_screen.dart';

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
  final double coverHeight = 200;
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
              body: ListView(
                  padding: EdgeInsets.zero,
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                buildTop(userModel),
                buildContent(userModel),
                const SizedBox(height: 16),
                buildBio(userModel),
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
        Positioned(
          top: top,
          child: buildProfileImage(user),
        ),
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
            user.knownAs,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          widget.visitedUserId == widget.currentUserId
              ? ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => EditProfileScreen(user: user),
                        ));
                  },
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                    shadowColor: MaterialStateProperty.all(Colors.black),
                    fixedSize: MaterialStateProperty.all(Size.fromWidth(300)),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                )
              : const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              user.githubId!.isEmpty
                  ? SizedBox()
                  : buildSocialIcon(FontAwesomeIcons.github,
                      'https://github.com/${user.githubId}'),
              const SizedBox(
                width: 12,
              ),
              user.twitterId!.isEmpty
                  ? SizedBox()
                  : buildSocialIcon(FontAwesomeIcons.twitter,
                      'https://twitter.com/${user.twitterId}'),
              const SizedBox(
                width: 12,
              ),
              user.instagramId!.isEmpty
                  ? SizedBox()
                  : buildSocialIcon(FontAwesomeIcons.instagram,
                      'https://www.instagram.com/${user.instagramId}'),
              const SizedBox(
                width: 12,
              ),
            ],
          ),
          Divider(),
        ],
      );

  Widget buildSocialIcon(IconData icon, String url) => CircleAvatar(
        radius: 25,
        child: Material(
          shape: CircleBorder(),
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Utils.launchURL(url);
            },
            child: Center(
                child: Icon(
              icon,
              size: 32,
            )),
          ),
        ),
      );

  Widget buildBio(UserModel user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '????????????',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.bio,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );

  Widget buildCoverImage(UserModel user) => Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.fill,
          image: user.coverPicture.isEmpty
              ? AssetImage('assets/images/Profile_background.png')
              : NetworkImage(user.profilePicture) as ImageProvider,
        )),
        height: coverHeight,
      );

  Widget buildProfileImage(UserModel user) => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: user.profilePicture.isEmpty
            ? AssetImage('assets/images/placeholder.png')
            : NetworkImage(user.profilePicture) as ImageProvider,
      );
}
