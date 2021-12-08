import 'package:flutter/cupertino.dart';

class MovieCountProvider extends ChangeNotifier {
  int _userMovieCount = 0;

  int get userMovieCount => _userMovieCount;

  void setCount(movieCount) {
    _userMovieCount = movieCount;
    notifyListeners();
  }
}
