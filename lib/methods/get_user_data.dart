// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/user.dart';
import 'package:movie_app/screens/home_page.dart';

class GetUserData extends StatelessWidget {
  const GetUserData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    String documentId = uid;

    print(auth.currentUser);

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return Container(
              color: Colors.white,
              child: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          UserDetails.email = data['email'].toString();
          UserDetails.username = data['username'].toString();
          UserDetails.password = data['password'].toString();
          // UserDetails.isAdmin = data['IsAdmin'];
          // UserDetails.profilePhotoUrl = data['ProfilePhotoUrl'].toString();
          UserDetails.uid = data['uid'];

          return HomePage();
        }
        return Container(
            color: Colors.white,
            child: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
