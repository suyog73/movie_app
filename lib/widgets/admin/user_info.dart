// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/helper/constants.dart';
import 'package:movie_app/methods/get_user_data.dart';
import 'package:movie_app/models/user_detail.dart';
import 'package:movie_app/screens/movie_create_screen.dart';
import 'package:movie_app/screens/movies/all_movies.dart';
import 'package:movie_app/widgets/movie_card.dart';
import 'package:movie_app/widgets/page_transition.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({
    Key? key,
    required this.username,
    required this.uid,
  }) : super(key: key);

  final String username, uid;

  @override
  State<UserInfo> createState() => _UserInfo();
}

class _UserInfo extends State<UserInfo> {
  var snapshots = FirebaseFirestore.instance
      .collection('movies')
      .orderBy('timeStamp', descending: true)
      .snapshots();

  String docIds = '';
  int totalPost = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              elevation: 0,
              backgroundColor: Colors.white.withOpacity(0.2),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${widget.username.toString()} Collection',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, ScaleTransition4(MovieCreateScreen()));
        },
        child: Icon(FontAwesomeIcons.plusSquare),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: kLinearGradient,
        ),
        child: Column(
          children: [
            Expanded(
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
                      try {
                        docIds = _notification[index]['docId'];
                      } catch (e) {
                        docIds = '';
                      }
                      return Column(
                        children: [
                          if (_notification[index]['uid'] == widget.uid)
                            MovieCard(
                              uid: _notification[index]['uid'],
                              docId: _notification[index]['docId'],
                              imageUrl: _notification[index]['imageUrl'],
                              movie: _notification[index]['movie'],
                              username: _notification[index]['creator'],
                              totalSeason: _notification[index]['totalSeason'],
                              storeIn: _notification[index]['storeIn'],
                              type: _notification[index]['type'],
                              isPersonal: true,
                              isAdmin: UserDetails.isAdmin,
                            ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
