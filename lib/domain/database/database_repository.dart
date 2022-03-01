import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techuni/common/constants/constants.dart';
import 'package:techuni/domain/question/models/question.dart';
import 'package:techuni/domain/user/models/user.dart';

class DatabaseServices {
  static Future<QuerySnapshot> getAllUsers() async {
    Future<QuerySnapshot> users = usersRef.get();

    return users;
  }

  Future<void> createQuestionData(QuestionModel question) async {
    final data = <String, dynamic>{
      'title': question.title,
      'comment': question.comment,
      'technology': question.technology,
      'environment': question.environment,
    };

    await questionsRef
        .add(
          data,
        )
        .catchError(
          (Object error) => print('Failed to set data: ${error.toString()}'),
        );
  }

  static Future<void> updateUserData(UserModel user) async {
    await usersRef.doc(currentUserId).update({
      'name': user.name,
      'bio': user.bio,
      'profilePicture': user.profilePicture,
      'coverPicture': user.coverPicture,
      'knownAs': user.knownAs,
      'twitterId': user.twitterId,
      'githubId': user.githubId,
      'instagramId': user.instagramId,
      'uid': '',
    });
  }
}