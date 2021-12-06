import 'package:flutter/foundation.dart';

class MovieDetailProvider extends ChangeNotifier {
  String _urlDownload = '';
  String _creator = '';
  String _movie = '';
  String _imdb = '';
  String _docId = '';

  String get getUrlDownload => _urlDownload;

  String get getCreator => _creator;

  String get getMovie => _movie;

  String get getImdb => _imdb;

  String get getDocId => _docId;

  void setUrl(url) {
    _urlDownload = url;
    notifyListeners();
  }

  void setCreator(creator) {
    _creator = creator;
    notifyListeners();
  }

  void setMovie(movie) {
    _movie = movie;
    notifyListeners();
  }

  void setImdb(imdb) {
    _imdb = imdb;
    notifyListeners();
  }

  void setDocId(docId) {
    _docId = docId;
    notifyListeners();
  }
}
