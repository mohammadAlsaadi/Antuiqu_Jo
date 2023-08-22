import 'package:firebase_auth/firebase_auth.dart';

// class AuthRepo {
//   final _firebaseAuth = FirebaseAuth.instance;
//   //registration method !
//   Future<void> signUp({required String email, required String password}) async {
//     try {
//       _firebaseAuth.createUserWithEmailAndPassword(
//           email: email, password: password);
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         throw Exception('this password is too weak !');
//       } else if (e.code == 'email-already-in-use') {
//         throw Exception('the account already exist ');
//       }
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }
// }

abstract class FireBaseAuthRepository {
  Stream<User?> get user;
  Future<User?> signUp({required String email, required String password});
  Future<void> logInWithEmailAndPasswoed(
      {required String email, required String password});
  Future<void> signOut();
}
