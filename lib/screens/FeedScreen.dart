import 'package:flutter/material.dart';
import 'package:techuni/Constants/Constants.dart';
import 'package:techuni/Screens/Home/HomeScreen.dart';
import 'package:techuni/Screens/Profile/ProfileScreen.dart';

class FeedScreen extends StatefulWidget {
  final String currentUserId;
  FeedScreen(this.currentUserId);
  @override
  _FeedScreenState createState() =>
      _FeedScreenState(this.currentUserId);
}

class _FeedScreenState extends State<FeedScreen> {
  final String currentUserId;
  var currentIndex = 0;
  _FeedScreenState(this.currentUserId);

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: [
        HomeScreen(
          // currentUserId: widget.currentUserId,
        ),
        HomeScreen(
          // currentUserId: widget.currentUserId,
        ),
        HomeScreen(
          // currentUserId: widget.currentUserId,
        ),
        ProfileScreen(
          currentUserId: widget.currentUserId,
          visitedUserId: widget.currentUserId,
        ),
        ProfileScreen(
          currentUserId: widget.currentUserId,
          visitedUserId: widget.currentUserId,
        ),
      ].elementAt(currentIndex),
      bottomNavigationBar: Container(
        width: size.width,
        height: 80,
        child: Stack(
          children: [
            Center(
              heightFactor: 0.6,
              child: FloatingActionButton(
                  backgroundColor: Palette.utilColor["grey"],
                  child: Icon(Icons.clean_hands),
                  elevation: 0.1,
                  onPressed: () {
                    setState(() {
                      currentIndex = 4;
                    });
                  }),
            ),
            Container(
              width: size.width,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.search,
                        color: currentIndex == 0
                            ? Palette.utilColor["lightblue"]
                            : Colors.grey.shade400,
                      ),
                      onPressed: () {
                        setBottomBarIndex(0);
                      }),
                  IconButton(
                    icon: Icon(
                      Icons.message,
                      color: currentIndex == 1
                          ? Palette.utilColor["lightblue"]
                          : Colors.grey.shade400,
                    ),
                    onPressed: () {
                      setBottomBarIndex(1);
                    },
                    splashColor: Colors.white,
                  ),
                  Container(
                    width: size.width * 0.20,
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.notifications,
                        color: currentIndex == 2
                            ? Palette.utilColor["lightblue"]
                            : Colors.grey.shade400,
                      ),
                      onPressed: () {
                        setBottomBarIndex(2);
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.person,
                        color: currentIndex == 3
                            ? Palette.utilColor["lightblue"]
                            : Colors.grey.shade400,
                      ),
                      onPressed: () {
                        setBottomBarIndex(3);
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
