// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print('login error:$e');
    }
  }

  static Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('signup error : $e');
    }
  }

  static Future<String> userUIDFromFirebaseAuth() async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;

    return userUID;
  }

  static Future<String> fitchUserUIDFromFirebase(
      {required String email, required String password}) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    String userUID = userCredential.user!.uid;

    return userUID;
  }
}
