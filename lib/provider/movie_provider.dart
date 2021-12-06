import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/widgets/movie_card.dart';

class MovieProvider extends ChangeNotifier {
  final List<Movie> _moviesCard = [];

  List<Movie> get moviesCard => _moviesCard;

  int get moviesSize => _moviesCard.length;

  void addMovie(String url, creator, movie, imdb, docId) {
    _moviesCard.add((Movie(
      imdb: imdb,
      creator: creator,
      url: url,
      movie: movie,
      docId: docId,
    )));
    notifyListeners();
  }

  void deleteMovie(Movie movie) async {
    _moviesCard.remove(movie);
    notifyListeners();
  }
}
