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
  const FeedScreen({Key? key}) : super(key: key);
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int _currentIndex = 0;

  _setBottomBarIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> _pages = [
    HomeScreen(
      currentUserId: currentUserId,
    ),
    ProductScreen(
      currentUserId: currentUserId,
    ),
    CalenderScreen(
      currentUserId: currentUserId,
    ),
    QuestionScreen(
      currentUserId: currentUserId,
    ),
    ProfileScreen(
      currentUserId: currentUserId,
      visitedUserId: currentUserId,
    ),
  ];

  @override
  void initState() {
    print(currentUserId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double iconSize = 50;
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: _currentIndex,
        onTap: _setBottomBarIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            // backgroundColor: Palette.lightgray,
            icon: Image.asset('assets/bottombar/unselected.png',
                height: iconSize),
            activeIcon:
                Image.asset('assets/bottombar/Home.png', height: iconSize),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/bottombar/unselected.png',
              height: iconSize,
            ),
            activeIcon:
                Image.asset('assets/bottombar/Product.png', height: iconSize),
            label: ' Products',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/bottombar/unselected.png',
                height: iconSize),
            activeIcon:
                Image.asset('assets/bottombar/Calender.png', height: iconSize),
            label: '  Calender',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/bottombar/unselected.png',
                height: iconSize),
            activeIcon:
                Image.asset('assets/bottombar/Question.png', height: iconSize),
            label: ' Questions',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/bottombar/unselected.png',
                height: iconSize),
            activeIcon:
                Image.asset('assets/bottombar/Mypage.png', height: iconSize),
            label: '  MyPage',
          ),
        ],
        type: BottomNavigationBarType.shifting,
        enableFeedback: true,
        iconSize: 18,
        selectedFontSize: 14,
        selectedItemColor: Colors.black,
      ),
    );
  }
}
