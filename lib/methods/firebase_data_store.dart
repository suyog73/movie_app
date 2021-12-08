import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_app/models/user_detail.dart';

Future sendDetailsToFireStore(creator, movieName, storeIn, totalSeason,
    imageUrl, timeStamp, uid, type) async {
  // calling firestore
  // calling user model
  // sending data
  CollectionReference movies = FirebaseFirestore.instance.collection('movies');

  await movies.add({
    "creator": creator,
    "movie": movieName,
    "storeIn": storeIn,
    "totalSeason": totalSeason,
    "imageUrl": imageUrl,
    "timeStamp": timeStamp,
    "uid": uid,
    "type": type,
    'likes': 1,
  }).then((value) async {
    await FirebaseFirestore.instance
        .collection('movies')
        .doc(value.id)
        .update({'docId': value.id});

    await FirebaseFirestore.instance
        .collection('users')
        .doc(UserDetails.uid)
        .update({"totalPosts": FieldValue.increment(1)});
    print("Movie added ${value.id}");
  }).catchError((e) => print('Error $e'));

  Fluttertoast.showToast(
    msg: type == 'Movie'
        ? 'Movie added successfully'
        : type == 'Anime'
            ? 'Anime added successfully'
            : 'Web series added successfully',
  );
}
