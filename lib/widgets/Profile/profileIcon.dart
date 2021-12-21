import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techuni/Models/UserModel.dart';
import 'package:techuni/Screens/Profile/EditProfileScreen.dart';

class ProfileWidget extends StatefulWidget {
  final UserModel user;
  final VoidCallback onClicked;

  const ProfileWidget({Key key, this.user, this.onClicked}) : super(key: key);
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(context),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    final image = widget.user.avatarUrl.isNotEmpty
        ? NetworkImage(widget.user.avatarUrl)
        : AssetImage('assets/placeholder.png');

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 64,
          height: 64,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(user: widget.user,)));
            }
          )
        )
      )
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
    color: Colors.white,
    all: 3,
    child: buildCircle(
      color: color,
      all: 4,
      child: Icon(
        Icons.edit,
        color: Colors.white,
        size: 10,
      ),
    ),
  );

  Widget buildCircle({
    @required Widget child,
    @required double all,
    @required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
