import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/models/user_detail.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    Key? key,
    required this.docId,
  }) : super(key: key);

  final String docId;

  @override
  Widget build(BuildContext context) {
    // deleteMovie
    Future deleteMovie() async {
      print("widget id $docId");
      FirebaseFirestore.instance.collection('movies').doc(docId).delete(); //
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
