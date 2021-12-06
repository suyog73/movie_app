// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/provider/movie_detail_provider.dart';
import 'package:movie_app/provider/movie_provider.dart';
import 'package:movie_app/screens/movie_create_screen.dart';
import 'package:movie_app/widgets/movie_card.dart';
import 'package:movie_app/widgets/page_transition.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // variables to store data coming from firebase
  String? creator, movie, imdb, imageUrl;

  // get data from firebase and to provider
  Future<void> getData() async {
    var collection = FirebaseFirestore.instance
        .collection('movies')
        .orderBy('timeStamp', descending: false);
    var querySnapshot = await collection.get();

    for (var i = Provider.of<MovieProvider>(context, listen: false).moviesSize;
        i < querySnapshot.docs.length;
        i++) {
      Map<String, dynamic> data = querySnapshot.docs[i].data();
      print('docId ${data['docId']}');

      Provider.of<MovieProvider>(context, listen: false).addMovie(
        data['imageUrl'],
        data['creator'],
        data['movie'],
        data['imdb'],
        data['docId'],
      );
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    int movieSize = Provider.of<MovieProvider>(context).moviesSize;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, ScaleTransition4(MovieCreateScreen()));
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
            child: RefreshIndicator(
              backgroundColor: Colors.lightBlueAccent,
              color: Colors.yellowAccent,
              child: FutureBuilder(
                future: getData(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    print(
                        "size       ${Provider.of<MovieProvider>(context, listen: false).moviesSize}");
                    return GridView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount:
                          Provider.of<MovieProvider>(context).moviesCard.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1),
                      itemBuilder: (context, index) {
                        final movie = Provider.of<MovieProvider>(context)
                            .moviesCard[index];
                        return MovieCard(movie: movie);
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
              onRefresh: () async {
                print("refresh1");
                return getData();
              },
            ),
          ),
        ],
      ),
    );
  }
}
