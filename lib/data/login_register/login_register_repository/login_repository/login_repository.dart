// ignore_for_file: avoid_print

import 'package:antique_jo/data/login_register/login_register_repository/auth/firebase_auth.dart';
import 'package:antique_jo/shared_prefrence_manager/shared_prefrence_manager.dart';

class LoginRepository {
  static Future<bool> isLoginSuccessful(
      {required String email, required String password}) async {
    try {
      String userUID =
          await Auth.fitchUserUIDFromFirebase(email: email, password: password);

      await SharedPreferenceManager.saveString(
        key: 'currentUID',
        value: userUID,
      );

      Auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print("Login Error from bloc: $e");
      return false;
    }
  }
}
