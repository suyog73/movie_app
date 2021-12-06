// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movie_app/helper/delete_button.dart';
import 'package:movie_app/helper/like_button.dart';
import 'package:movie_app/models/movie.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

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
                    image: NetworkImage(movie.url),
                    width: size.width * 0.39,
                    height: size.width * 0.39,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Creator : ${movie.creator}",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Movie : ${movie.movie}",
                          softWrap: true,
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 5),
                        const Text(
                          "Created on : Monday",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "IMDB : ${movie.imdb}/10",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
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
                    DeleteButton(movie: movie),
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
