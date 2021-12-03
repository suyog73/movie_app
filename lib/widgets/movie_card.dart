// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/helper/button.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Card(
        color: Colors.white60,
        shadowColor: Colors.blueGrey,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.only(top: 28.0),
          child: Column(
            children: [
              Row(
                children: [
                  Image(
                    image: AssetImage('assets/images/movies.png'),
                    width: size.width * 0.39,
                    height: size.width * 0.39,
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Creator : Suyog Patil",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 5),
                      const Text(
                        "Movie Name : Avengers",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 5),
                      const Text(
                        "Created on : Monday",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 5),
                      const Text(
                        "Created on : Monday",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 5),
                      const Text(
                        "Created on : Monday",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ActionButton(
                      color: Colors.blue,
                      buttonName: 'Like',
                      icon: FontAwesomeIcons.thumbsUp,
                    ),
                    ActionButton(
                      color: Colors.redAccent,
                      icon: FontAwesomeIcons.trash,
                      buttonName: 'Delete',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
