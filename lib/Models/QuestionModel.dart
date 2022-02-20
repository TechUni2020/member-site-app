import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionModel {
  String title;
  String comment;
  String technology;
  String environment;

  QuestionModel({
    required this.title,
    required this.comment,
    required this.technology,
    required this.environment,
  });

  factory QuestionModel.fromDoc(DocumentSnapshot doc) {
    return QuestionModel(
      title: doc['title'],
      comment: doc['comment'],
      technology: doc['technology'],
      environment: doc['environment'],
    );
  }
}
