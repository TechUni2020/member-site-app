import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techuni/models/auth_model.dart';
import 'package:techuni/screens/auth/signin.dart';

import 'package:firebase_core/firebase_core.dart';
import 'edit_mypage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;

class mypage extends StatefulWidget {
  @override
  _mypageState createState() => _mypageState();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(mypage());
}

class _mypageState extends State<mypage> {

  final user = _auth.currentUser;
  var personalinformation = [];
  final _firestore = FirebaseFirestore.instance;
  void getMessages() async {
    final messages = await _firestore.collection('user').doc(user.uid).get();
    // for (var message in messages) {
    personalinformation.add(messages.data()["department"]);
    personalinformation.add(messages.data()["class"]);
    personalinformation.add(messages.data()["grade"]);
    personalinformation.add(messages.data()["hobby"]);
    personalinformation.add(messages.data()["likefood"]);
    personalinformation.add(messages.data()["dislikefood"]);
    personalinformation.add(messages.data()["information"]);
    // }
  }
  // var flg= "";
  var flg = [];
  void flgs() async {
    final flgs = await _firestore.collection('user').doc(user.uid).get();
    flg.add(flgs.data()["flg"]);
    // for (var message in messages) {
    // flg = flgs.data()["flg"];
    // }
  }
  @override
  void initState() {
    super.initState();
    getMessages();
    flgs();
  }
  _mypageState();
  @override
  Widget build(BuildContext context) {

    // String helloWorld1(x){
    //   return x;
    // }
    String name = "福山祐史";
    String department = "経済学部";
    String part = "開発者";
    String year = "3年生";
    String hobby = "カメラ";
    String likefood = "バナナ";
    String dislikefood = "セロリ";

    // print("//////////////////////////");
    // print(user);
    // print("//////////////////////////");

    //////////////////////////////////////////////
    List<DocumentSnapshot> documentList = [];
    // 一覧取得
    // final push = Center(
    //   child: Column(
    //     children: <Widget>[
    //       ElevatedButton(
    //         child: Text('ドキュメント一覧取得'),
    //         onPressed: () async {
    //           // コレクション内のドキュメント一覧を取得
    //           final snapshot =
    //           await FirebaseFirestore.instance.collection('user').get();
    //           // 取得したドキュメント一覧をUIに反映
    //           setState(() {
    //             documentList = snapshot.documents;
    //           });
    //         },
    //       ),
    //       // コレクション内のドキュメント一覧を表示
    //       Column(
    //         children: documentList.map((document) {
    //           return ListTile(
    //             title: Text('${document['name']}さん'),
    //             subtitle: Text('${document['age']}歳'),
    //           );
    //         }).toList(),
    //       ),
    //     ],
    //   ),
    // );
    ///////////////////////////////////////////////
    // 指定して取得
    // String orderDocumentInfo = '';
    // final push = ElevatedButton(
    //   child: Text('ドキュメントを指定して取得'),
    //   onPressed: () async {
    //     // コレクションIDとドキュメントIDを指定して取得
    //     final document = await FirebaseFirestore.instance
    //         .collection('user')
    //         .doc(user.uid)
    //         .collection('information')
    //         .doc('id_123')
    //         .get();
    //     // 取得したドキュメントの情報をUIに反映
    //     setState(() {
    //        orderDocumentInfo =
    //       '${document['date']} ${document['price']}円';
    //     });
    //     ////////////////////zzzzzzzzzzzzz///////
    //     print(orderDocumentInfo);
    //     ////////////////////zzzzzzzzzzzzz///////
    //   },
    // );

    print(personalinformation.length);
    print(flg[0]);
    ///////////////////////////////////////
    // 新規登録
    //
    // final push =
    // Center(
    //   child: Column(
    //     children: <Widget>[
    //       // ElevatedButton(/* --- 省略 --- */),
    //       ElevatedButton(
    //         child: Text('サブコレクション＋ドキュメント作成'),
    //         onPressed: () async {
    //           // サブコレクション内にドキュメント作成
    //           await FirebaseFirestore.instance
    //               .collection('user')
    //               .doc(user.uid)
    //               .collection('information')
    //               .doc('id_123')
    //               .set({'price': 600, 'date': '9/13'});            },
    //       ),
    //     ],
    //   ),
    // );

    Future<void> instagramdialog(BuildContext context) async {
      //処理が重い(?)からか、非同期処理にする
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('InstagramアカウントURL'),
              content: TextField(
                decoration: InputDecoration(hintText: "URlを入力"),
              ),
              actions: <Widget>[
                FlatButton(
                  color: Colors.white,
                  textColor: Colors.blue,
                  child: Text('キャンセル'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  color: Colors.white,
                  textColor: Colors.blue,
                  child: Text('OK'),
                  onPressed: () {
                    //OKを押したあとの処理
                  },
                ),
              ],
            );
          });
    };

    Future<void> twitterdialog(BuildContext context) async {
      //処理が重い(?)からか、非同期処理にする
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('TwitterアカウントURL'),
              content: TextField(
                decoration: InputDecoration(hintText: "URlを入力"),
              ),
              actions: <Widget>[
                FlatButton(
                  color: Colors.white,
                  textColor: Colors.blue,
                  child: Text('キャンセル'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  color: Colors.white,
                  textColor: Colors.blue,
                  child: Text('OK'),
                  onPressed: () {
                    //OKを押したあとの処理
                  },
                ),
              ],
            );
          });
    };

    final instagram =
    Positioned(
      top: 30.0,
      right: 28.0,
      width: 80.0,
      height: 80.0,
      child: Container(
        child: GestureDetector(
          onTap: () {
            instagramdialog(context);
          },
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              // fit: BoxFit.fill,
              image: AssetImage('assets/images/instagram.png'),
            )),
          ),
        ),
      ),
    );


    final twitter = Positioned(
      top: 110.0,
      left: 38.0,
      width: 60.0,
      height: 60.0,
      child: Container(
        child: GestureDetector(
          onTap: () {
            twitterdialog(context);
          },
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  // fit: BoxFit.fill,
                  image: AssetImage('assets/images/twitter.png'),
                )),
          ),
        ),
      ),
    );

    final image = Container(
      width: 110.0,
      height: 110.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/images/IMG_5734.jpg'),
          )),
    );



    Widget maincard(String x, String y) {
      return Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              //   border: Border.all(color: Colors.black),
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            margin: EdgeInsets.only(
              top: 0,
              bottom: 10,
              right: 5,
              left: 5,
            ),
            child: Container(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 18,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(x),
                    padding: EdgeInsets.all(
                      (4),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(
                      (4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(y),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 30,
            width: 10.0,
            height: 10.0,
            child: GestureDetector(
              onTap: () {
                // 動作を記述
              },
              child: Opacity(
                opacity: 0.5,
                child: GestureDetector(
                  onTap: () {
                    // 処理を書く
                  },
                  child: Icon(Icons.border_color // アイコンの色を設定できる
                      ),

                ),
              ),
            ),
          ),
        ],
      );
    };

    Widget editmaincard(String x) {
      return Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              //   border: Border.all(color: Colors.black),
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            margin: EdgeInsets.only(
              top: 0,
              bottom: 10,
              right: 5,
              left: 5,
            ),
            child: Container(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 18,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(x),
                    padding: EdgeInsets.all(
                      (4),
                    ),
                  ),
                  Container(
                    height: 28,
                    margin: EdgeInsets.only(
                      top: 10, bottom: 0,
                    ),
                    padding: EdgeInsets.only(
                      top: 0, bottom: 0,
                    ),

                    child:TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18.0),
                    ),
      ),

                    Container(
                          height: 30,
                          // width: 60,
                          padding: EdgeInsets.only(
                            top: 10, bottom: 0,
                          ),

                          child:Container(
                            alignment: Alignment.bottomRight,
                            child:FlatButton(
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              color: Colors.white,
                              textColor: Colors.blue,
                              child: Text('OK'),
                              onPressed: () {
                                //OKを押したあとの処理
                              },

                            ),

                          ),

                  ),
                ],
              ),
            ),
          ),
        ],
      );
    };



    // void _onPressed() {
    //   var firebaseUser = FirebaseAuth.instance.currentUser;
    //   firestoreInstance
    //       .collection("users")
    //       .doc(firebaseUser.uid)
    //       .update({"age": 60}).then((_) {
    //     print("success!");
    //   });
    // }

    final gathermaincard = Container(
      child: Container(
        child: Table(
          // border: TableBorder.all(),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(5.0),
            1: FlexColumnWidth(5.0),
            2: FlexColumnWidth(5.0),
          },
          children: [
            TableRow(children: [
              editmaincard("学部"),
              maincard("クラス",personalinformation[1]),
              maincard("学年",personalinformation[2]),
            ]),
            TableRow(children: [
              maincard("趣味",personalinformation[3]),
              maincard("好きな食べ物",personalinformation[4]),
              maincard("嫌いな食べも物",personalinformation[5]),
            ]),
          ],
        ),
      ),
    );

    final information = Container(
      child: Container(
        decoration: BoxDecoration(
          //   border: Border.all(color: Colors.black),
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: EdgeInsets.only(
          right: 12, left: 12,
        ),
        constraints: BoxConstraints(
          minHeight: 120.0,
          maxWidth: 300.0,
        ),
        // decoration: BoxDecoration(
        //   border: Border.all(color: Colors.black),
        // ),
        child: Column(
          children: <Widget>[
            Container(
              child: Text("自己紹介"),
              padding: EdgeInsets.only(
                top: 10,bottom: 0,
              ),
            ),
            Container(
              child:Center(
                child: Text(personalinformation[6]),
              ),
              constraints: BoxConstraints(
                minHeight: 73.0,
                maxWidth: 250.0,
              ),
            ),
          ],
        ),
      ),
    );


    final editbotton = ElevatedButton(
      child: const Text('編集画面へ'),
      style: ElevatedButton.styleFrom(
        primary: Colors.orange,
        onPrimary: Colors.white,
      ),
    );

    return Scaffold(
        // appBar: appBarMain(context),
        // drawer: drawerMain(context),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/mypage.jpg'),
            fit: BoxFit.fill,
          )),
          child: Column(
              children: <Widget>[
                // push(),
                // aaa,
                Stack(
                  children: <Widget>[
                    instagram,
                    twitter,
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 62,
                          ),
                          image, //imageウィジェット呼び出し
                          Padding(
                            padding: EdgeInsets.only(
                              top: 5,bottom: 30,
                            ),
                            child:Text(
                              name,
                              style: TextStyle(
                                  fontSize: 30.0, fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(
                  bottom: 10,
                ),
                  child: Column(
                    children: <Widget>[
                      gathermaincard,
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      information,
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(
                     top: 5, right: 20,
                    ),
                    // child: Align(
                    //   alignment: Alignment.bottomRight,
                    //   child: ElevatedButton(
                      //   child: const Text('編集画面へ'),
                      //   style: ElevatedButton.styleFrom(
                      //     primary: Colors.orange,
                      //     onPrimary: Colors.white,
                      //   ),
                      //   onPressed: () {
                      //     // （1） 指定した画面に遷移する
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             // （2） 実際に表示するページ(ウィジェット)を指定する
                      //             builder: (context) => editpage()));
                      //   },
                      // ),
                    // )
                ),
              ],
            ),
      )
    );
  }
}
