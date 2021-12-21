import 'package:firebase_auth/firebase_auth.dart';
import 'package:techuni/Models/FirebaseError.dart';

class FirebaseAuthExceptionHandler {
  static FirebaseAuthResultStatus handleException(FirebaseAuthException e) {
    FirebaseAuthResultStatus result;
    switch (e.code) {
      case 'invalid-email':
        result = FirebaseAuthResultStatus.InvalidEmail;
        break;
      case 'wrong-password':
        result = FirebaseAuthResultStatus.WrongPassword;
        break;
      case 'user-disabled':
        result = FirebaseAuthResultStatus.UserDisabled;
        break;
      case 'user-not-found':
        result = FirebaseAuthResultStatus.UserNotFound;
        break;
      case 'operation-not-allowed':
        result = FirebaseAuthResultStatus.OperationNotAllowed;
        break;
      case 'too-many-requests':
        result = FirebaseAuthResultStatus.TooManyRequests;
        break;
      case 'email-already-in-use':
        result = FirebaseAuthResultStatus.EmailAlreadyExists;
        break;
      case 'weak-password':
        result = FirebaseAuthResultStatus.WeekPassword;
        break;
      default:
        result = FirebaseAuthResultStatus.Undefined;
    }
    return result;
  }

  static String exceptionMessage(FirebaseAuthResultStatus result) {
    String message = '';
    switch (result) {
      case FirebaseAuthResultStatus.Successful:
        message = 'ログインに成功しました。';
        break;
      case FirebaseAuthResultStatus.EmailAlreadyExists:
        message = '指定されたメールアドレスは既に使用されています。';
        break;
      case FirebaseAuthResultStatus.WrongPassword:
        message = 'パスワードが違います。';
        break;
      case FirebaseAuthResultStatus.WeekPassword:
        message = '6文字以上のパスワードを設定して下さい。';
        break;
      case FirebaseAuthResultStatus.InvalidEmail:
        message = 'メールアドレスが不正です。';
        break;
      case FirebaseAuthResultStatus.UserNotFound:
        message = '指定されたユーザーは存在しません。';
        break;
      case FirebaseAuthResultStatus.UserDisabled:
        message = '指定されたユーザーは無効です。';
        break;
      case FirebaseAuthResultStatus.OperationNotAllowed:
        message = '指定されたユーザーはこの操作を許可していません。';
        break;
      case FirebaseAuthResultStatus.TooManyRequests:
        message = '複数回間違えたため、時間を置いてやり直して下さい。';
        break;
      case FirebaseAuthResultStatus.Undefined:
        message = '不明なエラーが発生しました。';
        break;
    }
    return message;
  }
}
