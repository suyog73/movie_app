// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/helper/constants.dart';
import 'package:movie_app/screens/login_screen.dart';
import 'package:movie_app/widgets/component1.dart';
import 'package:movie_app/widgets/component2.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
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
                  height: size.width * 1.4,
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
                      SizedBox(height: 15),
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent.withOpacity(.7),
                        ),
                      ),
                      SizedBox(height: 25),
                      component1(FontAwesomeIcons.user, 'Username...', false,
                          true, context),
                      component1(FontAwesomeIcons.envelope, 'Email...', false,
                          true, context),
                      component1(Icons.lock_outline, 'Password...', true, false,
                          context),
                      component1(Icons.lock_outline, 'Confirm Password...',
                          true, false, context),
                      SizedBox(height: 15),
                      component2(
                        'SIGN UP',
                        2.6,
                        () {
                          // HapticFeedback.lightImpact();
                          Fluttertoast.showToast(msg: 'Sign up pressed');
                        },
                        context,
                      ),
                      SizedBox(),
                      InkWell(
                        onTap: () {
                          Fluttertoast.showToast(
                              msg: 'Already have an account ');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                        child: Text(
                          'Already have an account? Login here',
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
