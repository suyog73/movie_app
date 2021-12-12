// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/helper/constants.dart';
import 'package:movie_app/widgets/admin/user_list.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  var snapshots = FirebaseFirestore.instance.collection('users').snapshots();
  dynamic userNumbers;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance.collection('users').get().then((value) => {
          userNumbers = value.docs.length,
        });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 56),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(35),
            bottomRight: Radius.circular(35),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AppBar(
              elevation: 0,
              backgroundColor: Colors.white.withOpacity(0.2),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(FontAwesomeIcons.video),
                  SizedBox(width: 15),
                  Text(
                    'MovieAdda Users',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 35),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: kLinearGradient),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: StreamBuilder(
                stream: snapshots,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        notificationsSnapshots) {
                  if (notificationsSnapshots.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final _notification = notificationsSnapshots.data!.docs;
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: _notification.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          if (index == 0) SizedBox(height: 10),
                          if (index == 0)
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: Colors.redAccent, width: 2),
                                color: Colors.black12,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text(
                                  'Number of current users:- $userNumbers',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Colors.black45,
                                  ),
                                ),
                              ),
                            ),
                          UserList(
                            username: _notification[index]['username'],
                            email: _notification[index]['email'],
                            isAdmin: _notification[index]['isAdmin'],
                            uid: _notification[index]['uid'],
                          ),
                          if (index == _notification.length - 1)
                            SizedBox(height: 60),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
