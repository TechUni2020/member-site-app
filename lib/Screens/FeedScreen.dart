import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techuni/Constants/Constants.dart';
import 'package:techuni/Screens/Calender/CalenderScreen.dart';
import 'package:techuni/Screens/Home/HomeScreen.dart';
import 'package:techuni/Screens/Product/ProductScreen.dart';
import 'package:techuni/Screens/Profile/ProfileScreen.dart';
import 'package:techuni/Screens/Question/QuestionScreen.dart';

class FeedScreen extends StatefulWidget {
  final String? currentUserId;
  final int? page;

  const FeedScreen({Key? key, this.currentUserId, this.page}) : super(key: key);
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int? currentIndex;

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    currentIndex = widget.page!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: [
          HomeScreen(
            currentUserId: widget.currentUserId!,
          ),
          ProductScreen(
            currentUserId: widget.currentUserId!,
          ),
          CalenderScreen(
            currentUserId: widget.currentUserId!,
          ),
          QuestionScreen(
            currentUserId: widget.currentUserId!,
          ),
          ProfileScreen(
            currentUserId: widget.currentUserId!,
            visitedUserId: widget.currentUserId!,
          ),
        ].elementAt(currentIndex!),
        bottomNavigationBar: Container(
            width: size.width,
            height: 80,
            child: Container(
              width: size.width,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: SizedBox(
                      height: 75,
                      width: 75,
                      child: currentIndex == 0
                          ? Image.asset(
                              'assets/NavigationBar/Hedgehog_unselected.png')
                          : Image.asset(
                              'assets/NavigationBar/Hedgehog_unselected.png'),
                    ),
                    onPressed: () {
                      setBottomBarIndex(0);
                    },
                    splashColor: Colors.white,
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.search,
                        color: currentIndex == 1
                            ? Palette.red
                            : Colors.grey.shade400,
                      ),
                      onPressed: () {
                        setBottomBarIndex(1);
                      }),
                  Container(
                    width: size.width * 0.20,
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.notifications,
                        color: currentIndex == 2
                            ? Palette.red
                            : Colors.grey.shade400,
                      ),
                      onPressed: () {
                        setBottomBarIndex(2);
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.person,
                        color: currentIndex == 3
                            ? Palette.red
                            : Colors.grey.shade400,
                      ),
                      onPressed: () {
                        setBottomBarIndex(3);
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.person,
                        color: currentIndex == 4
                            ? Palette.red
                            : Colors.grey.shade400,
                      ),
                      onPressed: () {
                        setBottomBarIndex(4);
                      }),
                ],
              ),
            )));
  }
}
