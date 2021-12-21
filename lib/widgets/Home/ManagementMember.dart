import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techuni/Models/UserModel.dart';

class ManagementMenberScroller extends StatelessWidget {
  final String title;
  final List<UserModel> users;
  ManagementMenberScroller({@required this.title, @required this.users});

  //幹部の情報カード
  memberCard(List<UserModel> users, height) {
      return Row(
        children: users.map((UserModel user) =>
          Container(
            width: 150,
            margin: EdgeInsets.only(right: 20),
            height: height,
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(user.avatarUrl)
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(3),
                      child: Text(
                        user.name,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(3),
                      child: Text(
                        user.role,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                )
                )
              ),
          ).toList()
      );
    }

  @override
  Widget build(BuildContext context) {
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 50;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
            fit: BoxFit.fill,
            alignment: Alignment.topCenter,
            child: Column(children: [
              Container(
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [memberCard(users, categoryHeight)],
              )
            ])),
      ),
    );
  }
}
