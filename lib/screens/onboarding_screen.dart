// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:movie_app/helper/constants.dart';
import 'package:movie_app/screens/login_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(FontAwesomeIcons.video),
              SizedBox(width: 15),
              Text(
                'MovieAdda',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          // color: Colors.white,
          decoration: BoxDecoration(
            gradient: kLinearGradient,
          ),
          padding: EdgeInsets.only(top: 85),
          child: IntroductionScreen(
            pages: [
              PageViewModel(
                title: 'Welcome to MovieAdda',
                body:
                    'The perfect platform to store all your favourite movies and also see the collection of movies of other users.',
                image: Image(
                  image: AssetImage('assets/images/Avengers.jpg'),
                  width: 350,
                ),
                decoration: kGetPageDecoration(),
              ),
              PageViewModel(
                title: 'Create a Movie',
                body:
                    'Just create a movie by uploading it\'s poster and some details. After that you can set a movie watched or not.',
                image: Image(image: AssetImage('assets/images/Inception.jpg')),
                decoration: kGetPageDecoration(),
              ),
              PageViewModel(
                title: 'Easy to Use',
                body:
                    'You can create, update and delete easily. If you like a movie you can like it and also make it watch later.',
                image:
                    Image(image: AssetImage('assets/images/money_heist.jpg')),
                decoration: kGetPageDecoration(),
              ),
            ],
            done: Text(
              'Login',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            onDone: () => goToHome(context),
            showSkipButton: true,
            skip: Text(
              'Skip',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            onSkip: () => goToHome(context),
            next: Icon(
              Icons.arrow_forward,
              color: Colors.black,
              size: 26,
            ),
            dotsDecorator: kGetDotDecoration(),
            globalBackgroundColor: Color(0xffd5adc8),
            skipFlex: 0,
            nextFlex: 0,
          ),
        ),
      ),
    );
  }

  // ToDo push replacement
  void goToHome(context) => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
}
