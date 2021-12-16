import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/screens/admin_screen.dart';

dynamic userNumbers;

class AdminButton extends StatelessWidget {
  const AdminButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance.collection('users').get().then((value) => {
          userNumbers = value.docs.length,
        });

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdminScreen(userNumbers: userNumbers),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Icon(
            FontAwesomeIcons.userShield,
            color: Colors.red,
            size: 30,
          ),
          SizedBox(width: 15),
          Text(
            'Admin Screen',
            style: TextStyle(
              fontSize: 20,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
