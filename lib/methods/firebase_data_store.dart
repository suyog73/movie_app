import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

sendDetailsToFireStore(creator, movie, imdb, imageUrl) async {
  // calling firestore
  // calling user model
  // sending data
  CollectionReference movies = FirebaseFirestore.instance.collection('movies');

  await movies
      .add({
        "creator": creator,
        "movie": movie,
        "imdb": imdb,
        "imageUrl": imageUrl,
      })
      .then((value) => print("Movie added"))
      .catchError((e) => print('Error $e'));
  Fluttertoast.showToast(msg: 'Data added successfully');
}
