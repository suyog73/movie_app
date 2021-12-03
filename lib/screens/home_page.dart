// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/provider/movie_provider.dart';
import 'package:movie_app/widgets/movie_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<MovieProvider>(context, listen: false)
              .addMovie(MovieCard());
        },
        child: Icon(
          FontAwesomeIcons.plusSquare,
          size: 28,
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.yellow,
            height: 90,
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.video),
                  SizedBox(width: 12),
                  Text(
                    'Movies',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: Provider.of<MovieProvider>(context).moviesCard.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
              itemBuilder: (context, index) {
                return Provider.of<MovieProvider>(context).moviesCard[index];
              },
            ),
          )
        ],
      ),
    );
  }
}
