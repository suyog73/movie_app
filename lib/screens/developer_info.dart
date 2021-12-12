// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_app/helper/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperInfo extends StatelessWidget {
  static String id = 'developer_info_screen';

  const DeveloperInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: kLinearGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/images/robot.json'),
            SizedBox(height: 50),
            Text(
              'Suyog Patil',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Flutter Developer',
              style: TextStyle(
                color: Colors.black38,
                fontSize: 20,
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    _launchURL('https://www.instagram.com/suyog_patil7/');
                  },
                  child: Icon(
                    FontAwesomeIcons.instagram,
                    size: 30,
                    color: Colors.redAccent,
                  ),
                ),
                InkWell(
                  onTap: () {
                    _launchURL(
                        'https://www.linkedin.com/in/suyog-patil-9401a7204/');
                  },
                  child: Icon(
                    FontAwesomeIcons.linkedinIn,
                    size: 30,
                    color: Colors.blueAccent,
                  ),
                ),
                InkWell(
                  onTap: () {
                    _launchURL('https://github.com/suyog73');
                  },
                  child: Icon(FontAwesomeIcons.github, size: 30),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _launchURL(_url) async {
  if (!await launch(_url)) throw 'Could not launch $_url';
}
