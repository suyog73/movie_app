// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';
import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movie_app/helper/validators.dart';
import 'package:movie_app/methods/firebase_data_store.dart';
import 'package:movie_app/methods/firebase_upload.dart';
import 'package:movie_app/models/user_detail.dart';
import 'package:movie_app/widgets/button/action_button.dart';
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
  TextEditingController movieNameController = TextEditingController();
  TextEditingController storeController = TextEditingController(text: 'HDD');
  TextEditingController totalSeasonController = TextEditingController();

  int isMovie = 1;
  int isSeries = 0;
  int isAnime = 0;

  setSelectedRadio(value) {
    setState(() {
      isMovie = value;
      isSeries = value;
      isAnime = value;
    });
  }

  String label = '';
  String type = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    switch (isMovie) {
      case 1:
        label = 'Movie name';
        type = 'Movie';
        break;
      case 2:
        label = 'Web Series name';
        type = 'Web Series';
        break;
      case 3:
        label = 'Anime name';
        type = 'Anime';
        break;
      default:
        label = 'Name';
        type = 'Movie';
    }

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
                    'MovieAdda',
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
      body: ModalProgressHUD(
        inAsyncCall: visibility,
        child: Container(
          padding: EdgeInsets.only(top: size.height * 0.2),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffb0f3f1),
                Color(0xffffcfdf),
              ],
            ),
          ),
          child: Column(
            children: [
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
                                ? Container(
                                    width: size.width * 0.45,
                                    height: size.width * 0.39,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image(
                                        image: AssetImage(
                                            'assets/images/movies.png'),
                                        alignment: Alignment.center,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: size.width * 0.45,
                                    height: size.width * 0.39,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.file(
                                        _image!,
                                        alignment: Alignment.center,
                                        fit: BoxFit.fitWidth,
                                      ),
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
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 55),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 38.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.shapes,
                                      color: Colors.lightBlueAccent,
                                    ),
                                    SizedBox(width: 10),
                                    Text('Category'),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: 1,
                                    activeColor: Colors.lightBlueAccent,
                                    onChanged: (value) {
                                      setState(() {
                                        setSelectedRadio(value);
                                      });
                                    },
                                    groupValue: isMovie,
                                  ),
                                  Text('Movie'),
                                  Radio(
                                    value: 2,
                                    activeColor: Colors.lightBlueAccent,
                                    groupValue: isSeries,
                                    onChanged: (value) {
                                      setSelectedRadio(value);
                                    },
                                  ),
                                  Text('Web Series'),
                                  Radio(
                                    value: 3,
                                    activeColor: Colors.lightBlueAccent,
                                    groupValue: isAnime,
                                    onChanged: (value) {
                                      setSelectedRadio(value);
                                    },
                                  ),
                                  Text('Anime'),
                                ],
                              ),
                              InputFields(
                                label: label,
                                controller: movieNameController,
                                onChange: (creatorName) {
                                  movieNameController.value =
                                      movieNameController.value
                                          .copyWith(text: creatorName);
                                },
                                icon: FontAwesomeIcons.film,
                                validator: creatorValidator,
                                keyBoardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                              ),
                              InputFields(
                                label: 'Stored in',
                                controller: storeController,
                                onChange: (movieName) {
                                  storeController.value = storeController.value
                                      .copyWith(text: movieName);
                                },
                                icon: FontAwesomeIcons.solidFolder,
                                validator: movieValidator,
                                keyBoardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                              ),
                              InputFields(
                                label: 'No. of seasons',
                                controller: totalSeasonController,
                                onChange: (movieName) {
                                  totalSeasonController.value =
                                      totalSeasonController.value
                                          .copyWith(text: movieName);
                                },
                                icon: FontAwesomeIcons.sortNumericDown,
                                keyBoardType: TextInputType.number,
                                validator: (v) {
                                  if (v!.isEmpty) {
                                    return 'Number of seasons are required';
                                  }
                                },
                                textInputAction: TextInputAction.done,
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        FocusScope.of(context).unfocus();

                                        setState(() {
                                          visibility = true;
                                        });
                                        await uploadImage();
                                        await sendDetailsToFireStore(
                                            UserDetails.username,
                                            movieNameController.text,
                                            storeController.text,
                                            totalSeasonController.text,
                                            urlDownload ??
                                                "https://play-lh.googleusercontent.com/5Y97X0kfd9uznAJXFOmLXEjqNTjJNZ07nKOmPvPbFUoUKkBswIYGIzMOzcYnF9bMdw",
                                            DateTime.now()
                                                .toUtc()
                                                .millisecondsSinceEpoch,
                                            UserDetails.uid,
                                            type);
                                        Navigator.pop(context);
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
      ),
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
      Fluttertoast.showToast(msg: 'Failed to pick image $e');
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
