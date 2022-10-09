import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Auth extends ChangeNotifier {
  final FirebaseAuth auth;

  String userUid;
  String get getUserUid => userUid;

  Auth({@required this.auth});

  //FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User> get user => auth.authStateChanges();

  Future<String> createAccount({String email, String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      notifyListeners();
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Weak Password';
        //print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
        //print('The account already exists for that email.');
      }
      return e.message;
    } catch (e) {
      //print(e);
    }
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
      return e.message;
    }
  }

  Future<String> signOut() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
    return 'success';
  }
}