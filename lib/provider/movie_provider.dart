import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MovieProvider extends ChangeNotifier {
  final List<Widget> _moviesCard = [];

  List<Widget> get moviesCard => _moviesCard;

  void addMovie(Widget movieCard) {
    _moviesCard.add(movieCard);
    notifyListeners();
  }
}
