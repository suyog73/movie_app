import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future sendDetailsToFireStore(creator, movie, imdb, imageUrl, timeStamp) async {
  // calling firestore
  // calling user model
  // sending data
  CollectionReference movies = FirebaseFirestore.instance.collection('movies');

  await movies.add({
    "creator": creator,
    "movie": movie,
    "imdb": imdb,
    "imageUrl": imageUrl,
    "timeStamp": timeStamp,
  }).then((DocumentReference docRef) async {
    print("Movie added ${docRef.id}");
    await docRef.update({'docId': docRef.id});
  }).catchError((e) => print('Error $e'));
  Fluttertoast.showToast(msg: 'Data added successfully');
}
