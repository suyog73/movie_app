// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

bool isLike = false;

class LikeButton extends StatefulWidget {
  const LikeButton({Key? key, required this.docId}) : super(key: key);

  final String docId;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        setState(() {
          isLike = !isLike;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isLike ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
            color: Colors.redAccent,
            size: 30,
          ),
        ],
      ),
    );
  }
}
