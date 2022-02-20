import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techuni/Constants/Constants.dart';
import 'package:techuni/Models/UserModel.dart';
import 'package:techuni/Services/AuthServices.dart';
import 'package:techuni/Services/DatabaseServices.dart';
import 'package:techuni/Widgets/Home/UserIcon.dart';

class HomeScreen extends StatefulWidget {
  final String currentUserId;

  const HomeScreen({Key? key, required this.currentUserId}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<QuerySnapshot>? _users;

  @override
  void initState() {
    _users = DatabaseServices.getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _users,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Palette.yellow),
              ),
            );
          }
          UserModel userModel = UserModel.fromDoc(snapshot.data!.docs[0]);
          return Scaffold(
              // appBar: MainAppBar(),
              body: Container(
                  child: Column(
            children: [
              SizedBox(height: 30),
              //     Expanded(
              //       child: GridView.count(
              //         crossAxisCount: 2,
              //         children: List.generate(
              //             this.selectedCategory!.subCategories!.length, (index) {
              //           return GestureDetector(
              //             onTap: () {
              //               var subCat = this.selectedCategory!.subCategories![index];
              //               catSelection.selectedSubCategory = cartService
              //                   .getCategoryFromCart(subCat as SubCategory);
              //               Utils.mainAppNav.currentState!.pushNamed('/detailspage');
              //             },
              //             child: Container(
              //                 child: Column(
              //               children: [
              //                 ClipOval(
              //                   child: Image.asset(
              //                       'assets/imgs/' +
              //                           this
              //                               .selectedCategory!
              //                               .subCategories![index]
              //                               .imgName! +
              //                           '.png',
              //                       fit: BoxFit.cover,
              //                       width: 100,
              //                       height: 100),
              //                 ),
              //                 SizedBox(height: 10),
              //                 Text(this.selectedCategory!.subCategories![index].name!,
              //                     style:
              //                         TextStyle(color: this.selectedCategory!.color))
              //               ],
              //             )),
              //           );
              //         }),
              //       ),
              //     )
            ],
          )));
        });
  }
}
