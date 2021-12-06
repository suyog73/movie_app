import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/provider/movie_detail_provider.dart';
import 'package:movie_app/provider/movie_provider.dart';
import 'package:movie_app/widgets/movie_card.dart';
import 'package:provider/provider.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    MovieDetailProvider movieDetailProvider =
        Provider.of<MovieDetailProvider>(context);

    // deleteMovie
    Future deleteMovie() async {
      print("widget id ${movie.docId}");
      FirebaseFirestore.instance
          .collection('movies')
          .doc(movie.docId)
          .delete(); //
    }

    return InkWell(
      onTap: () async {
        await deleteMovie();
        Provider.of<MovieProvider>(context, listen: false).deleteMovie(movie);

        print(
            "size delete ${Provider.of<MovieProvider>(context, listen: false).moviesSize}");
      },
      child: Container(
        height: 35,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.redAccent),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Delete',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            SizedBox(width: 5),
            Icon(
              FontAwesomeIcons.trash,
              color: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }
}
