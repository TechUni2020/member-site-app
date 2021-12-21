import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techuni/Constants/Constants.dart';
import 'package:techuni/Models/UserModel.dart';
import 'package:techuni/Screens/Profile/ProfileScreen.dart';
import 'package:techuni/Services/AuthServices.dart';
import 'package:techuni/Services/DatabaseServices.dart';
import 'package:techuni/Widgets/Home/HomeScreenWidget.dart';

class HomeScreen extends StatefulWidget {
  final String currentUserId;

  const HomeScreen({Key key, this.currentUserId}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<QuerySnapshot> _users;
  TextEditingController _searchController = TextEditingController();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  TabController _controller;
  List<Widget> _buildTabs() {
    return [
      Tab(text: 'ホーム'),
      Tab(text: '中級者'),
      Tab(text: '開発者'),
      Tab(text: 'フロントエンド'),
      Tab(text: 'バックエンド'),
    ];
  }

  List<Widget> _buildTabPages() {
    return [
      HomeScreenWidget(
        currentUserId: widget.currentUserId,
      ),
      HomeScreenWidget(
        currentUserId: widget.currentUserId,
      ),
      HomeScreenWidget(
        currentUserId: widget.currentUserId,
      ),
      HomeScreenWidget(
        currentUserId: widget.currentUserId,
      ),
      HomeScreenWidget(
        currentUserId: widget.currentUserId,
      ),
    ];
  }

  clearSearch() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _searchController.clear());
    setState(() {
      _users = null;
    });
  }

  buildUserTile(UserModel user) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: user.avatarUrl.isEmpty
            ? AssetImage('assets/placeholder.png')
            : NetworkImage(user.avatarUrl),
      ),
      title: Text(user.name),
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(
          builder: (context) => ProfileScreen(
            currentUserId: widget.currentUserId,
            visitedUserId: user.id,
          )));
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.30;
   return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DefaultTabController(
      length: _buildTabs().length,
      child: Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.white,
        title: TextField(
          controller: _searchController,
          cursorColor: Palette.utilColor["grey"],
          decoration: InputDecoration(
            fillColor: Colors.grey[200],
            contentPadding: EdgeInsets.symmetric(vertical: 15),
            hintText: 'IDで検索',
            hintStyle: TextStyle(color: Colors.black),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.black),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.black,
              ),
              onPressed: () {
                clearSearch();
              },
            ),
          ),
          onChanged: (input) {
            if (input.isNotEmpty) {
              setState(() {
                _users = DatabaseServices.searchUsers(input);
              });
            }
          },
        ),
        bottom: TabBar(
          controller: _controller,
          tabs: _buildTabs(),
          isScrollable: true,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Palette.utilColor["grey"]
        )
      ),
      body: Stack(children: [
        _users == null
            ? TabBarView(
              controller: _controller,
              children: _buildTabPages(),
            )
            : FutureBuilder(
                future: _users,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data.docs.length == 0) {
                    return Center(
                      child: TextButton(
                child: Text('ログアウト', style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600)),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text('ログアウトしてもよろしいですか？'),
                        actions: [
                          TextButton(
                            child: Text('ログアウト'),
                            onPressed: () async {
                              AuthService().logout();
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('キャンセル'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
                },),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        UserModel user =
                            UserModel.fromDoc(snapshot.data.docs[index]);
                        return buildUserTile(user);
                      });
                }),
      ]))));
  }
}
