import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  static Future<UserCredential?> createAccount(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // await credential.user!.sendEmailVerification();
      await credential.user!.updateDisplayName(name);

      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<UserCredential?> login(
      {required String email, required String password}) async {
    try {
      final credential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
