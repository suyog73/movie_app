// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_app/helper/constants.dart';
import 'package:movie_app/models/movie_detail.dart';
import 'package:movie_app/widgets/button/delete_button.dart';
import 'package:movie_app/widgets/button/like_button.dart';
import 'package:movie_app/models/user_detail.dart';
import 'package:movie_app/widgets/button/watch_later_button.dart';

DateTime dateToday = DateTime.now();
String bigDate = dateToday.toString().substring(0, 10);
String year = bigDate.substring(0, 4);
String month = bigDate.substring(5, 7);
String date = bigDate.substring(8, 10);

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required this.movie,
    required this.uid,
    required this.creator,
    required this.totalSeason,
    required this.imageUrl,
    required this.docId,
    required this.storeIn,
    required this.type,
  }) : super(key: key);

  final String movie, uid, creator, docId, totalSeason, imageUrl, storeIn, type;

  @override
  Widget build(BuildContext context) {
    MovieDetails.movie = movie;
    MovieDetails.uid = uid;
    MovieDetails.creator = creator;
    MovieDetails.docId = docId;
    MovieDetails.totalSeason = totalSeason;
    MovieDetails.imageUrl = imageUrl;
    MovieDetails.storeIn = storeIn;
    MovieDetails.type = type;
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5)
          .copyWith(top: 28),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaY: 1,
                sigmaX: 1,
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.white.withOpacity(0.5),
                    ],
                    begin: AlignmentDirectional.topStart,
                    end: AlignmentDirectional.bottomEnd,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10, left: 10),
                          width: size.width * 0.45,
                          height: size.width * 0.39,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image(
                              image: NetworkImage(imageUrl),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 55),
                              Text(
                                "Name : $movie",
                                softWrap: true,
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Created : $date-$month-$year",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Stored in: $storeIn",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Type: $type",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28.0, vertical: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LikeButton(docId: docId),
                          WatchLaterButton(),
                          if (UserDetails.uid == uid) DeleteButton(docId: docId)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: creator == UserDetails.username
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xff9dfbc8),
                          Color(0xfff5f186),
                        ],
                      )
                    : kLinearGradient,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
              child: Text(
                creator,
                style: TextStyle(fontSize: 19),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
