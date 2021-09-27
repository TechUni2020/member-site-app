import 'package:flutter/material.dart';
import 'package:techuni/models/auth_model.dart';
import 'package:techuni/screens/auth/signin.dart';

import 'edit_mypage.dart';


class mypage extends StatefulWidget {
  @override
  _mypageState createState() => _mypageState();
}

class _mypageState extends State<mypage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: appBarMain(context),
        // drawer: drawerMain(context),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
              ),
              Container(
                width: 110.0,
                height: 110.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/IMG_5734.jpg'),
                    )),
              ),
              Text(
                "ユーザーネーム",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                child: const Text('Button'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  // （1） 指定した画面に遷移する
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          // （2） 実際に表示するページ(ウィジェット)を指定する
                          builder: (context) => editpage()));
                },
              ),
              Text(
                "About",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "文章が入る",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )
    );
  }
}

/////////////////////////////////////////////////////////////////////////
class _MyFirestorePageState extends State<FirestoreLoad> {
  // ドキュメント情報を入れる箱を用意
  List<DocumentSnapshot> documentList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('LoadAlldocs'),
              onPressed: () async {
                // 指定コレクションのドキュメント一覧を取得
                final snapshot = await Firestore.instance
                    .collection('test_collection1')
                    .getDocuments();
                // ドキュメント一覧を配列で格納
                setState(() {
                  documentList = snapshot.documents;
                });
              },
            ),
            // ドキュメント情報を表示
            Column(
              children: documentList.map((document) {
                return ListTile(
                  title: Text('name:${document['name']}'),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}