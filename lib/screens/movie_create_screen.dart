// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/widgets/action_button.dart';
import 'package:movie_app/widgets/input_fields.dart';

class MovieCreateScreen extends StatefulWidget {
  const MovieCreateScreen({Key? key}) : super(key: key);

  @override
  State<MovieCreateScreen> createState() => _MovieCreateScreenState();
}

class _MovieCreateScreenState extends State<MovieCreateScreen> {
  // form key
  final _formKey = GlobalKey<State>();

  // Controllers
  TextEditingController creatorController = TextEditingController();
  TextEditingController movieController = TextEditingController();
  TextEditingController imdbController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.yellow,
            height: 90,
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.video),
                  SizedBox(width: 12),
                  Text(
                    'Movies',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: size.height * 0.1),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image(
                      image: AssetImage('assets/images/movies.png'),
                      width: 150,
                      height: 150,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Welcome to MovieAdda',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 55),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 38.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          InputField(
                              label: 'Creator',
                              controller: creatorController,
                              onChange: (creatorName) {
                                creatorController.value = creatorController
                                    .value
                                    .copyWith(text: creatorName);
                              },
                              icon: FontAwesomeIcons.userShield),
                          InputField(
                            label: 'Movie Name',
                            controller: movieController,
                            onChange: (movieName) {
                              movieController.value = movieController.value
                                  .copyWith(text: movieName);
                            },
                            icon: FontAwesomeIcons.film,
                          ),
                          InputField(
                            label: 'IMDB Rating',
                            controller: imdbController,
                            onChange: (movieName) {
                              imdbController.value = imdbController.value
                                  .copyWith(text: movieName);
                            },
                            icon: FontAwesomeIcons.imdb,
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: ActionButton(
                                  icon: FontAwesomeIcons.times,
                                  buttonName: 'Cancel',
                                  color: Colors.redAccent,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showDialogBox();
                                },
                                child: ActionButton(
                                  icon: FontAwesomeIcons.solidSave,
                                  buttonName: 'Save',
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showDialogBox() {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Image(
                image: AssetImage('assets/images/movies.png'),
                width: 50,
                height: 50,
              ),
              SizedBox(width: 10),
              Text('MovieAdda'),
            ],
          ),
          content: const Text('Do you want to save this movie?'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellowAccent,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                      child: Text(
                        'No',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                InkWell(
                  onTap: () {},
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.lightBlueAccent),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                        child: Text(
                          'Yes',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      )),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
