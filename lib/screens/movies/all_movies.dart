// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/helper/constants.dart';
import 'package:movie_app/models/user_detail.dart';
import 'package:movie_app/screens/movie_create_screen.dart';
import 'package:movie_app/widgets/movie_card.dart';
import 'package:movie_app/widgets/page_transition.dart';
import '../app_drawer.dart';

class AllMoviesPage extends StatefulWidget {
  const AllMoviesPage({Key? key}) : super(key: key);

  @override
  State<AllMoviesPage> createState() => _AllMoviesPageState();
}

class _AllMoviesPageState extends State<AllMoviesPage> {
  var snapshot = FirebaseFirestore.instance
      .collection('movies')
      .orderBy('timeStamp', descending: true)
      .snapshots();

  String docIds = '';

  @override
  Widget build(BuildContext context) {
    print("All Movie");
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: AppDrawer(),
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
                  SizedBox(width: 35),
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
        child: Icon(
          FontAwesomeIcons.plusSquare,
          size: 28,
        ),
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
                          if (index == 0) SizedBox(height: 10),
                          MovieCard(
                            uid: _notification[index]['uid'],
                            docId: docIds,
                            imageUrl: _notification[index]['imageUrl'],
                            movie: _notification[index]['movie'],
                            username: _notification[index]['creator'],
                            totalSeason: _notification[index]['totalSeason'],
                            storeIn: _notification[index]['storeIn'],
                            type: _notification[index]['type'],
                            isAdmin: false,
                            isPersonal: false,
                          ),
                          if (index == _notification.length - 1)
                            SizedBox(height: 60),
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
