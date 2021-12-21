import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techuni/Models/UserModel.dart';
import 'package:techuni/Services/DatabaseServices.dart';
import 'package:techuni/Widgets/Home/ManagementMember.dart';

class HomeScreenWidget extends StatefulWidget {
  final String currentUserId;

  const HomeScreenWidget({Key key, this.currentUserId}) : super(key: key);
  @override
  _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  List<Widget> usersData = [];
  List<UserModel> managememtUsersList;

  getAllUsers() async {
    List<UserModel> allUsers = await DatabaseServices.getAllUsers();
    allUsers.forEach((user) {
      usersData.add(Container(
          height: 150,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      user.name,
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      user.uid,
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Image.network(
                  user.avatarUrl,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          )));
    });
  }

  getManagementUsers() async {
    managememtUsersList = await DatabaseServices.getManagementUsers();
  }

  @override
  void initState() {
    super.initState();
    getAllUsers();
    getManagementUsers();
    controller.addListener(() {
      double value = controller.offset / 119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.30;
    return Container(
      height: size.height,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: closeTopContainer ? 0 : 1,
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: size.width,
                alignment: Alignment.topCenter,
                height: closeTopContainer ? 0 : categoryHeight,
                child: ManagementMenberScroller(
                  title: '幹部',
                  users: managememtUsersList,
                )),
          ),
          Expanded(
              child: ListView.builder(
                  controller: controller,
                  itemCount: usersData.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    double scale = 1.0;
                    if (topContainer > 0.5) {
                      scale = index + 0.5 - topContainer;
                      if (scale < 0) {
                        scale = 0;
                      } else if (scale > 1) {
                        scale = 1;
                      }
                    }
                    return Opacity(
                      opacity: scale,
                      child: Transform(
                        transform: Matrix4.identity()..scale(scale, scale),
                        alignment: Alignment.bottomCenter,
                        child: Align(
                            heightFactor: 0.7,
                            alignment: Alignment.topCenter,
                            child: usersData[index]),
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}
