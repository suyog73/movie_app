// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/helper/constants.dart';
import 'package:movie_app/models/user_detail.dart';
import 'package:movie_app/screens/movie_create_screen.dart';
import 'package:movie_app/screens/movies/all_movies.dart';
import 'package:movie_app/widgets/movie_card.dart';
import 'package:movie_app/widgets/page_transition.dart';
import '../app_drawer.dart';

class UserMovies extends StatefulWidget {
  const UserMovies({Key? key}) : super(key: key);

  @override
  State<UserMovies> createState() => _UserMovies();
}

class _UserMovies extends State<UserMovies> {
  // variables to store data coming from firebase
  String? creator, movie, imdb, imageUrl;

  var snapshots = FirebaseFirestore.instance
      .collection('movies')
      .orderBy('timeStamp', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 56),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Colors.white.withOpacity(0.2),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(FontAwesomeIcons.video),
                    SizedBox(width: 15),
                    Text(
                      'Your Collection',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 31),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Icon(FontAwesomeIcons.home),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context, ScaleTransition4(MovieCreateScreen()));
                },
                child: Icon(FontAwesomeIcons.plusSquare),
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: kLinearGradient,
          ),
          child: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  backgroundColor: Colors.lightBlueAccent,
                  color: Colors.yellowAccent,
                  onRefresh: () async => snapshots,
                  child: StreamBuilder(
                    stream: snapshots,
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            notificationsSnapshots) {
                      if (notificationsSnapshots.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final _notification = notificationsSnapshots.data!.docs;
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: _notification.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              if (_notification[index]['uid'] ==
                                  UserDetails.uid)
                                MovieCard(
                                  uid: _notification[index]['uid'],
                                  docId: _notification[index]['docId'],
                                  imageUrl: _notification[index]['imageUrl'],
                                  movie: _notification[index]['movie'],
                                  creator: _notification[index]['creator'],
                                  totalSeason: _notification[index]
                                      ['totalSeason'],
                                  storeIn: _notification[index]['storeIn'],
                                  type: _notification[index]['type'],
                                ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
