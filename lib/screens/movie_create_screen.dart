// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movie_app/helper/validators.dart';
import 'package:movie_app/methods/firebase_data_store.dart';
import 'package:movie_app/methods/firebase_upload.dart';
import 'package:movie_app/screens/home_page.dart';
import 'package:movie_app/widgets/action_button.dart';
import 'package:movie_app/widgets/input_fields.dart';
import 'package:path/path.dart' as path;

class MovieCreateScreen extends StatefulWidget {
  const MovieCreateScreen({Key? key}) : super(key: key);

  @override
  State<MovieCreateScreen> createState() => _MovieCreateScreenState();
}

class _MovieCreateScreenState extends State<MovieCreateScreen> {
  // form key
  final GlobalKey<FormState> _formKey = GlobalKey();

  // image source
  File? _image;

  // upload task
  UploadTask? task;

  String? urlDownload;
  bool visibility = false;

  // Controllers
  TextEditingController creatorController = TextEditingController();
  TextEditingController movieController = TextEditingController();
  TextEditingController imdbController = TextEditingController();

  // add movie
  Future addMovie() async {
    var collection = FirebaseFirestore.instance
        .collection('movies')
        .orderBy('id', descending: false);
    var querySnapshot = await collection.get();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ModalProgressHUD(
      inAsyncCall: visibility,
      child: Scaffold(
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
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
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
                    Text(
                      'Upload Movie Poster',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Stack(
                        children: [
                          _image == null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image(
                                    image:
                                        AssetImage('assets/images/movies.png'),
                                    alignment: Alignment.center,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.fill,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.file(
                                    _image!,
                                    alignment: Alignment.center,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                          Positioned(
                            child: InkWell(
                              onTap: showDialogBoxForUploadImage,
                              child: Icon(
                                FontAwesomeIcons.camera,
                                color: Colors.yellowAccent,
                                size: 20,
                              ),
                            ),
                            bottom: 10,
                            right: 10,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Welcome to MovieAdda',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 55),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 38.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            InputFields(
                              label: 'Creator',
                              controller: creatorController,
                              onChange: (creatorName) {
                                creatorController.value = creatorController
                                    .value
                                    .copyWith(text: creatorName);
                              },
                              icon: FontAwesomeIcons.userShield,
                              validator: creatorValidator,
                              keyBoardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                            ),
                            InputFields(
                              label: 'Movie Name',
                              controller: movieController,
                              onChange: (movieName) {
                                movieController.value = movieController.value
                                    .copyWith(text: movieName);
                              },
                              icon: FontAwesomeIcons.film,
                              validator: movieValidator,
                              keyBoardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                            ),
                            InputFields(
                              label: 'IMDB Rating',
                              controller: imdbController,
                              onChange: (movieName) {
                                imdbController.value = imdbController.value
                                    .copyWith(text: movieName);
                              },
                              icon: FontAwesomeIcons.imdb,
                              keyBoardType: TextInputType.number,
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return 'IMDB is required';
                                }
                                double myVal = double.parse(v);
                                if (myVal > 10 || myVal < 0) {
                                  return 'Please enter valid imdb rating between 0-10';
                                }
                              },
                              textInputAction: TextInputAction.done,
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
                                    if (_formKey.currentState!.validate()) {
                                      showDialogBoxForSave();
                                    }
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
      ),
    );
  }

  // alert box while saving movie details
  void showDialogBoxForSave() {
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
                  onTap: () async {
                    try {
                      setState(() {
                        visibility = true;
                      });
                      await uploadImage();
                      await sendDetailsToFireStore(
                        creatorController.text,
                        movieController.text,
                        imdbController.text,
                        urlDownload ??
                            "https://play-lh.googleusercontent.com/5Y97X0kfd9uznAJXFOmLXEjqNTjJNZ07nKOmPvPbFUoUKkBswIYGIzMOzcYnF9bMdw",
                        DateTime.now().toUtc().millisecondsSinceEpoch,
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    } catch (e) {
                      setState(() {
                        visibility = false;
                      });
                      print(e);
                    }
                  },
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
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // alert box for upload image
  void showDialogBoxForUploadImage() {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an option to upload image'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    getImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.lightBlueAccent,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.cameraRetro,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Camera',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                InkWell(
                  onTap: () async {
                    getImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.lightBlueAccent,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.images,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Gallery',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // Pick image
  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      final imgTemp = File(image.path);

      setState(() {
        _image = imgTemp;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }

  // Upload image
  Future uploadImage() async {
    if (_image == null) return;

    final imageName = path.basename(_image!.path);
    final destination = 'files/$imageName';

    task = FirebaseUpload.uploadFile(destination, _image!);

    if (task == null) return null;

    final snapshot = await task!.whenComplete(() {});
    urlDownload = await snapshot.ref.getDownloadURL();
  }
}
