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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        height: 120,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bottombar/bottom_background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: _currentIndex,
          onTap: _setBottomBarIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SizedBox(
                  height: 50,
                  child:
                      Image.asset('assets/bottombar/Hedgehog_unselected.png')),
              activeIcon: SizedBox(
                  height: 50,
                  child: Image.asset('assets/bottombar/Hedgehog_selected.png')),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              activeIcon: Icon(Icons.business_center),
              label: ' Products',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              activeIcon: Icon(Icons.school_outlined),
              label: '  Calender',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              activeIcon: Icon(Icons.settings_accessibility),
              label: ' Questions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              activeIcon: Icon(Icons.settings_accessibility),
              label: '  MyPage',
            ),
          ],

          // type: BottomNavigationBarType.shifting,
          // // ここで色を設定していても、shiftingにしているので
          // // Itemの方のbackgroundColorが勝ちます。
          // enableFeedback: true,
          // // IconTheme系統の値が優先されます。
          // iconSize: 18,
          // // 横向きレイアウトは省略します。
          // // landscapeLayout: 省略
          // selectedFontSize: 20,
          // selectedIconTheme: const IconThemeData(size: 30, color: Colors.green),
          // selectedLabelStyle: const TextStyle(color: Colors.red),
          // // ちなみに、LabelStyleとItemColorの両方を選択した場合、ItemColorが勝ちます。
          // selectedItemColor: Colors.black,
          // unselectedFontSize: 15,
          // unselectedIconTheme:
          //     const IconThemeData(size: 25, color: Colors.white),
          // unselectedLabelStyle: const TextStyle(color: Colors.purple),
          // // IconTheme系統の値が優先されるのでこの値は適応されません。
          // unselectedItemColor: Colors.red,
        ),
      ),
    );
  }
}
