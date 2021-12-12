import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    Key? key,
    required this.docId,
    required this.imageUrl,
  }) : super(key: key);

  final String docId, imageUrl;

  @override
  Widget build(BuildContext context) {
    // deleteMovie
    Future deleteMovie() async {
      print("delete post id $docId");
      FirebaseFirestore.instance.collection('movies').doc(docId).delete();
      FirebaseStorage.instance.refFromURL(imageUrl).delete();
    }

    return InkWell(
      onTap: () async {
        await deleteMovie();
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
