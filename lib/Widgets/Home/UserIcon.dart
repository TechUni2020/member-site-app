import 'package:flutter/material.dart';
import 'package:techuni/Widgets/Home/IconFont.dart';

class UserIcon extends StatelessWidget {
  Color? color;
  String? iconName;
  double size;
  double padding;

  UserIcon({this.color, this.iconName, this.size = 30, this.padding = 10});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
          color: this.color,
          padding: EdgeInsets.all(this.padding),
          child: IconFont(
              color: Colors.white, iconName: this.iconName, size: this.size)),
    );
  }
}
