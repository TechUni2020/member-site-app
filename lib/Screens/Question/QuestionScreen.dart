import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techuni/Constants/Constants.dart';
import 'package:techuni/Screens/Question/CreateQuestionScreen.dart';

class QuestionScreen extends StatefulWidget {
  final String currentUserId;

  const QuestionScreen({Key? key, required this.currentUserId})
      : super(key: key);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('質問箱'),
      ),
      // body: ,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.question_answer_outlined),
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>
                    CreateQuestionScreen(currentUserId: currentUserId),
              ));
        },
      ),
    );
  }
}
