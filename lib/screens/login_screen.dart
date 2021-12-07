// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_app/helper/constants.dart';
import 'package:movie_app/screens/signup_screen.dart';
import 'package:movie_app/widgets/component1.dart';
import 'package:movie_app/widgets/component2.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _transform;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    )..addListener(() {
        setState(() {});
      });

    _transform = Tween<double>(begin: 2, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: kLinearGradient,
            ),
            child: Opacity(
              opacity: _opacity.value,
              child: Transform.scale(
                scale: _transform.value,
                child: Container(
                  width: size.width * .9,
                  height: size.width * 1.1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.1),
                        blurRadius: 90,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(),
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent.withOpacity(.7),
                        ),
                      ),
                      SizedBox(),
                      component1(Icons.email_outlined, 'Email...', false, true,
                          context),
                      component1(Icons.lock_outline, 'Password...', true, false,
                          context),
                      component2(
                        'LOGIN',
                        2.6,
                        () {
                          // HapticFeedback.lightImpact();
                          Fluttertoast.showToast(msg: 'Login button pressed');
                        },
                        context,
                      ),
                      SizedBox(),
                      InkWell(
                        onTap: () {
                          Fluttertoast.showToast(
                              msg: 'Create a new account pressed');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupScreen()),
                          );
                        },
                        child: Text(
                          'Create a new account',
                          style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
