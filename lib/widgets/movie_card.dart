// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movie_app/helper/delete_button.dart';
import 'package:movie_app/helper/like_button.dart';

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
                        "IMDB : 6.5/10",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28.0, vertical: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LikeButton(),
                    DeleteButton(),
                  ],
                ),
              ),
              Divider(
                color: Colors.black45,
              ),
              Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the ',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
