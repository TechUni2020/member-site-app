import 'package:flutter/material.dart';
import '../utils/const.dart';


class AppbarMain extends StatelessWidget with PreferredSizeWidget {
  final Widget title;
  final bool isAction;

  AppbarMain({
    this.title,
    this.isAction,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: title != null ? title : Image.asset(
        'assets/logo.png', //Tech.Uniのアイコンとか入れて
        height: 200,
      ),
        backgroundColor: Const.utilColor["green"],
        actions: isAction
            ? <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: <Widget>[
                      CircleAvatar(
                         backgroundImage:
                        NetworkImage("https://www.vhv.rs/dpng/d/256-2569650_men-profile-icon-png-image-free-download-searchpng.png"),
                        ),
                      Positioned(
                        right: 0.0,
                        width: 40.0,
                        height: 40.0,
                        child: RawMaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/mypage"); //ページ作ってね
                            print("マイページへ遷移");
                          },
                          shape: CircleBorder(),
                        ),
                      ),
                    ],
                  ),
                )
            
              ]
            : null);
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}

