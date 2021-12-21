import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:intl/intl.dart";

class UserContainer extends StatefulWidget {

  const UserContainer({Key key})
      : super(key: key);
  @override
  _UserContainerState createState() => _UserContainerState();
}

class _UserContainerState extends State<UserContainer>
    with SingleTickerProviderStateMixin {
  var formatter = new DateFormat('yyyy/MM/dd HH:mm');

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                          // builder: (context) => ProfileScreen(
                          //   currentUserId: widget.currentUserId,
                          //   visitedUserId: widget.author.id,
                          // )
                      ));
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage('https://pics.prcm.jp/03ae92492cb72/84973601/jpeg/84973601_480x480.jpeg'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'みさき',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    '1時間前に足跡がつきました',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[350],
                      width: 0.5,
                    ),
                  ),
                ),
                child: Padding(
                    padding:
                        const EdgeInsets.only(left: 40, top: 5, bottom: 10),
                    child: Text(
                      '初めましてみさきです。是非ゴルフご一緒したいです！よろしくお願いします！',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )),
              ),
              SizedBox(height: 10),
              RaisedButton(
                onPressed: () {},
                child: Text('メッセージを送る'),
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ));
          
  }
}
