// SignOut method
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_app/screens/login_screen.dart';

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
}
