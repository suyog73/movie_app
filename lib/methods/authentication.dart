import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_app/screens/Auth%20Screens/login_screen.dart';

final _auth = FirebaseAuth.instance;

class Authentication {
  Future<void> logout({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.signOut();

      Fluttertoast.showToast(msg: 'Successfully logged out');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  // SignUp Method
  Future signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          return "Your email address appears to be malformed.";
        case "wrong-password":
          return "Your password is wrong.";
        case "user-not-found":
          return "User with this email doesn't exist.";
        case "user-disabled":
          return "User with this email has been disabled.";
        case "too-many-requests":
          return "Too many requests";
        case "operation-not-allowed":
          return "Signing in with Email and Password is not enabled.";
        default:
          return "An undefined Error happened.";
      }
    }
  }
}
