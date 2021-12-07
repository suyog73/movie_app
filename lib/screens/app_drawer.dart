// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movie_app/helper/constants.dart';
import 'package:movie_app/methods/authentication.dart';
import 'package:movie_app/methods/get_user_data.dart';
import 'package:movie_app/models/user.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String? username;

  String? email;

  @override
  void initState() {
    super.initState();
    GetUserData();
  }

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: kLinearGradient,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: InkWell(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage("assets/images/movies.png"),
                    backgroundColor: Colors.amber[50],
                  ),
                  onTap: () {},
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 48),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(FontAwesomeIcons.solidUser),
                        SizedBox(width: 10),
                        Text(
                          UserDetails.username.toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Icon(FontAwesomeIcons.solidEnvelope),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            UserDetails.email.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Icon(FontAwesomeIcons.lock),
                        SizedBox(width: 10),
                        Text(
                          UserDetails.password.toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Icon(Icons.vpn_key),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            UserDetails.uid.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        await Authentication().logout(context: context);

                        setState(() {
                          showSpinner = false;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.4,
                        padding: EdgeInsets.all(8).copyWith(left: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0xffd5adc8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.signOutAlt,
                              size: 30,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'LogOut',
                              style: TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
