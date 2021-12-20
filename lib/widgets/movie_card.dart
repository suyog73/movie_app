// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_app/helper/constants.dart';
import 'package:movie_app/widgets/admin/user_info.dart';
import 'package:movie_app/widgets/button/delete_button.dart';
import 'package:movie_app/widgets/button/like_button.dart';
import 'package:movie_app/models/user_detail.dart';

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
    required this.username,
    required this.totalSeason,
    required this.imageUrl,
    required this.docId,
    required this.storeIn,
    required this.type,
    this.isAdmin = false,
    required this.isPersonal,
  }) : super(key: key);

  final String movie,
      uid,
      username,
      docId,
      totalSeason,
      imageUrl,
      storeIn,
      type;
  final bool isAdmin, isPersonal;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String parts = 'Total Parts';
    if (type == 'Web Series') {
      parts = 'Total seasons';
    }

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
                              SizedBox(height: isPersonal ? 10 : 55),
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
                              Text(
                                "$parts: $totalSeason",
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
                          if (UserDetails.uid == uid || isAdmin)
                            DeleteButton(docId: docId, imageUrl: imageUrl)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (!isPersonal) // user is looking the list of specific users movies
            Positioned(
              right: 20,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UserInfo(username: username, uid: uid),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: username == UserDetails.username
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
                    username,
                    style: TextStyle(fontSize: 19),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
